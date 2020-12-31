//
//  Health.swift
//  HealthKitDemo
//
//  Created by Ataias Pereira Reis on 31/12/20.
//

import Foundation
import HealthKit

class Health: ObservableObject {
    @Published var age = ""
    @Published var biologicalSex = ""
    @Published var bloodType = ""
    @Published var heightInMeters: Double?
    @Published var weightInKilograms: Double?

    public func readHealthInfo() {
        do {
            let (age, biologicalSex, bloodType) = try Self.getAgeSexAndBloodType()
            self.age = String(age)
            self.biologicalSex = String(describing: biologicalSex)
            self.bloodType = String(describing: bloodType)

            loadMostRecentHeight()
            loadMostRecentWeight()
        } catch {
            print("Failed reading health data: \(error.localizedDescription)")
        }
    }

    static private func getAgeSexAndBloodType() throws -> (age: Int,
                                                           biologicalSex: HKBiologicalSex,
                                                           bloodType: HKBloodType) {
        let healthKitStore = HKHealthStore()

        do {

            // 1. This method throws an error if these data are not available.
            // TODO: Can we use health kit with combine? This way we could get notified of changes in blood type and biological sex
            let birthdayComponents =  try healthKitStore.dateOfBirthComponents()
            let biologicalSex =       try healthKitStore.biologicalSex()
            let bloodType =           try healthKitStore.bloodType()

            // 2. Use Calendar to calculate age.
            let today = Date()
            let calendar = Calendar.current
            let todayDateComponents = calendar.dateComponents([.year],
                                                              from: today)
            let thisYear = todayDateComponents.year!
            let age = thisYear - birthdayComponents.year!

            // 3. Unwrap the wrappers to get the underlying enum values.
            let unwrappedBiologicalSex = biologicalSex.biologicalSex
            let unwrappedBloodType = bloodType.bloodType

            return (age, unwrappedBiologicalSex, unwrappedBloodType)
        }
    }

    static private func getMostRecentSample(for sampleType: HKSampleType,
                                            completion: @escaping (HKQuantitySample?, Error?) -> Swift.Void) {

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

                    completion(nil, error)
                    return
                }

                completion(mostRecentSample, nil)
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

        Self.getMostRecentSample(for: heightSampleType) { (sample, error) in
            guard let sample = sample else {
                print("Some error occurred: \(error?.localizedDescription ?? "unknown")")
                return
            }

            // 2. Convert the height sample to meters, save to the profile model, and update the user interface.
            let heightInMeters = sample.quantity.doubleValue(for: HKUnit.meter())
            self.heightInMeters = heightInMeters
        }
    }

    private func loadMostRecentWeight() {

        guard let weightSampleType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
            print("Body Mass Sample Type is no longer available in HealthKit")
            return
        }

        Self.getMostRecentSample(for: weightSampleType) { (sample, error) in

            guard let sample = sample else {
                print("Some error occurred: \(error?.localizedDescription ?? "unknown")")
                return
            }

            let weightInKilograms = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            self.weightInKilograms = weightInKilograms
        }
    }


}
