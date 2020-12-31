//
//  ContentView.swift
//  HealthKitDemo
//
//  Created by Ataias Pereira Reis on 31/12/20.
//

import SwiftUI

struct ContentView: View {
    let age: String
    let sex: String
    let bloodType: String

    let weight: Double?
    let height: Double?
    var bmi: Double? {
        guard let weight = weight, let height = height else {
            return nil
        }
        return weight / (height * height)
    }

    var formattedWeight: String {
        guard let weight = weight else { return "Unknown" }
        let weightFormatter = MassFormatter()
        weightFormatter.isForPersonMassUse = true
        return weightFormatter.string(fromKilograms: weight)
    }

    var formattedHeight: String {
        guard let height = height else { return "Unknown" }
        let heightFormatter = LengthFormatter()
        heightFormatter.isForPersonHeightUse = true
        return heightFormatter.string(fromMeters: height)
    }

    var formattedBMI: String {
        guard let bmi = bmi else { return "Unknown" }
        return String(format: "%.02f", bmi)
    }

    var body: some View {
        Form {
            Section(header: Text("User Info")) {
                DataRowView(title: "Age", value: age)
                DataRowView(title: "Sex", value: sex)
                DataRowView(title: "Blood Type", value: bloodType)
            }
            Section(header: Text("Weight & Height")) {
                DataRowView(title: "Weight", value: formattedWeight)
                DataRowView(title: "Height", value: formattedHeight)
                DataRowView(title: "BMI", value: formattedBMI)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            age: "21",
            sex: "Female",
            bloodType: "A+",
            weight: 100.5,
            height: 2.2
        )
    }
}
