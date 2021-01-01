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
    case noSamples
}

class Health: ObservableObject {
    @Published var age = ""
    @Published var biologicalSex = ""
    @Published var bloodType = ""
    @Published var heightInMeters: Double?
    @Published var weightInKilograms: Double?
    @Published var workoutSamples = [WorkoutData]()

    public func readHealthInfo() {
        do {
            let store = HKHealthStore()
            self.age = String(try Self.getAge(store).get()) // FIXME should treat each one separately?
            self.biologicalSex = String(describing: try Self.getSex(store).get())
            self.bloodType = String(describing: try Self.getBloodType(store).get())

            loadMostRecentWorkouts()
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

    static private func getMostRecentSample<T: HKSample>(for sampleType: HKSampleType,
                                            completion: @escaping (Result<[T], Error>) -> Void) {
        getMostRecentSamples(for: sampleType, limit: 1, completion: completion)
    }

    static private func getMostRecentSamples<T: HKSample>(for sampleType: HKSampleType,
                                            limit: Int,
                                            completion: @escaping (Result<[T], Error>) -> Void) {

        // 1. Use HKQuery to load the most recent samples.
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                              end: Date(),
                                                              options: .strictEndDate)

        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                              ascending: false)

        let sampleQuery = HKSampleQuery(sampleType: sampleType,
                                        predicate: mostRecentPredicate,
                                        limit: limit,
                                        sortDescriptors: [sortDescriptor]) { (query, samples, error) in

            // 2. Always dispatch to the main thread when complete.
            DispatchQueue.main.async {

                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                guard let samples = samples as? [T] else {
                    completion(.failure(AppError.noSamples))
                    return
                }

                completion(.success(samples))
            }
        }

        HKHealthStore().execute(sampleQuery)
    }

    private func loadMostRecentWorkouts() {

//        guard let workoutSampleType = HKSampleType.quantityType(forIdentifier: .height) else {
//            print("Height Sample Type is no longer available in HealthKit")
//            return
//        }

        Self.getMostRecentSamples(for: HKSampleType.workoutType(), limit: 20) { (result: Result<[HKWorkout],Error>) in
            switch result {
            case .success(let samples):
                print(samples)
                self.workoutSamples = samples.map {
                    WorkoutData(id: $0.uuid, date: $0.startDate, activityType: String(describing: $0.workoutActivityType), duration: $0.duration)
                }
            case .failure(let error):
                print("Some error occurred: \(error.localizedDescription)")
            }

        }
    }

    private func loadMostRecentHeight() {

        // 1. Use HealthKit to create the Height Sample Type
        guard let heightSampleType = HKSampleType.quantityType(forIdentifier: .height) else {
            print("Height Sample Type is no longer available in HealthKit")
            return
        }

        Self.getMostRecentSample(for: heightSampleType) { (result: Result<[HKQuantitySample],Error>) in
            switch result {
            case .success(let samples):
                print("Convert the height sample to meters, save to the profile model, and update the user interface.")
                self.heightInMeters = samples.first?.quantity.doubleValue(for: HKUnit.meter())
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

        Self.getMostRecentSample(for: weightSampleType) { (result: Result<[HKQuantitySample],Error>) in
            switch result {
            case .success(let samples):
                self.weightInKilograms = samples.first?.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            case .failure(let error):
                print("Some error occurred: \(error.localizedDescription)")
            }
        }
    }


}
