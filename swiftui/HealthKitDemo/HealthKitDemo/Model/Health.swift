//
//  Health.swift
//  HealthKitDemo
//
//  Created by Ataias Pereira Reis on 31/12/20.
//

import Foundation
import HealthKit

enum AppError: Error {
    case invalidAge
}

class Health: ObservableObject {
    @Published var age = ""
    @Published var biologicalSex = ""
    @Published var bloodType = ""
    @Published var heightInMeters: Double?
    @Published var weightInKilograms: Double?

    public func readHealthInfo() {
        do {
            let store = HKHealthStore()
            self.age = String(try Self.getAge(store).get()) // FIXME should treat each one separately?
            self.biologicalSex = String(describing: try Self.getSex(store).get())
            self.bloodType = String(describing: try Self.getBloodType(store).get())

            loadMostRecentHeight()
            loadMostRecentWeight()
        } catch {
            print("Failed reading health data: \(error.localizedDescription)")
        }
    }

    static private func getAge(_ healthKitStore: HKHealthStore) -> Result<Int,Error> {
        let result = Result { try healthKitStore.dateOfBirthComponents() }
        return result
            .flatMap { birthdayComponents in
                guard let birthday = birthdayComponents.date,
                      let age = Calendar.current.dateComponents([.year], from: birthday, to: Date()).year else {
                    return .failure(AppError.invalidAge)
                }
                return .success(age)
            }
    }

    static private func getSex(_ healthKitStore: HKHealthStore) -> Result<HKBiologicalSex,Error> {
        return Result { try healthKitStore.biologicalSex().biologicalSex }
    }

    static private func getBloodType(_ healthKitStore: HKHealthStore) -> Result<HKBloodType,Error> {
        return Result { try healthKitStore.bloodType().bloodType }
    }

    static private func getMostRecentSample(for sampleType: HKSampleType,
                                            completion: @escaping (Result<HKQuantitySample, Error>) -> Void) {

        // 1. Use HKQuery to load the most recent samples.
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                              end: Date(),
                                                              options: .strictEndDate)

        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                              ascending: false)

        let limit = 1

        let sampleQuery = HKSampleQuery(sampleType: sampleType,
                                        predicate: mostRecentPredicate,
                                        limit: limit,
                                        sortDescriptors: [sortDescriptor]) { (query, samples, error) in

            // 2. Always dispatch to the main thread when complete.
            DispatchQueue.main.async {

                guard let samples = samples,
                      let mostRecentSample = samples.first as? HKQuantitySample else {

                    completion(.failure(error!)) // FIXME should force wrap here?
                    return
                }

                completion(.success(mostRecentSample))
            }
        }

        HKHealthStore().execute(sampleQuery)
    }

    private func loadMostRecentHeight() {

        // 1. Use HealthKit to create the Height Sample Type
        guard let heightSampleType = HKSampleType.quantityType(forIdentifier: .height) else {
            print("Height Sample Type is no longer available in HealthKit")
            return
        }

        Self.getMostRecentSample(for: heightSampleType) { result in
            switch result {
            case .success(let sample):
                print("Convert the height sample to meters, save to the profile model, and update the user interface.")
                let heightInMeters = sample.quantity.doubleValue(for: HKUnit.meter())
                self.heightInMeters = heightInMeters
            case .failure(let error):
                print("Some error occurred: \(error.localizedDescription)")
            }

        }
    }

    private func loadMostRecentWeight() {

        guard let weightSampleType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
            print("Body Mass Sample Type is no longer available in HealthKit")
            return
        }

        Self.getMostRecentSample(for: weightSampleType) { result in
            switch result {
            case .success(let sample):
                let weightInKilograms = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
                self.weightInKilograms = weightInKilograms
            case .failure(let error):
                print("Some error occurred: \(error.localizedDescription)")
            }
        }
    }


}
