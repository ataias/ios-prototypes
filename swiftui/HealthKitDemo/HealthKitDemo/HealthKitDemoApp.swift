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
        HealthKitSetupAssistant.authorizeHealthKit { result in
            switch result {
            case .success(()):
                print("HealthKit Authorization Request Successfully Processed. This does not necessarily mean the user gave you permissions though.")
            case .failure(let error):
                let baseMessage = "HealthKit Authorization Failed"
                print("\(baseMessage). Reason: \(error.localizedDescription)")
            }
        }
    }
}
