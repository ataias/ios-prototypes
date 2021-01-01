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
                    authorizeHealthkit() // TODO what if this failed? it will still call readHealthInfo afterwards. You could use combine to chain those
                    model.readHealthInfo()
                }
        }
    }

    func authorizeHealthkit() {
        // TODO use a combine future here! You can reference https://github.com/AvdLee/CombineSwiftPlayground in the future section to see how
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
