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

    init() {
        let (age, biologicalSex, bloodType) = try! getAgeSexAndBloodType()
        self.age = String(age)
        self.biologicalSex = String(describing: biologicalSex)
        self.bloodType = String(describing: bloodType)
    }

    func getAgeSexAndBloodType() throws -> (age: Int,
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

}
