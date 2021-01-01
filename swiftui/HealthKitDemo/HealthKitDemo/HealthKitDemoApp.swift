//
//  HealthKitDemoApp.swift
//  HealthKitDemo
//
//  Created by Ataias Pereira Reis on 31/12/20.
//

import SwiftUI

@main
struct HealthKitDemoApp: App {
    @ObservedObject var model = Health()
    var body: some Scene {
        WindowGroup {
            ContentView(age: model.age, sex: model.biologicalSex, bloodType: model.bloodType, weight: model.weightInKilograms, height: model.heightInMeters)
                .onAppear {
                    authorizeHealthkit()
                    model.readHealthInfo()
                }
        }
    }

    func authorizeHealthkit() {
        HealthKitSetupAssistant.authorizeHealthKit { (authorized, error) in

            guard authorized else {
                let baseMessage = "HealthKit Authorization Failed"

                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                } else {
                    print(baseMessage)
                }

                return
            }

            print("HealthKit Successfully Authorized.")
        }
    }
}