//
//  ContentView.swift
//  HealthKitDemo
//
//  Created by Ataias Pereira Reis on 31/12/20.
//

import SwiftUI

struct ContentView: View {
    let age: String

    var body: some View {
        Form {
            Section(header: Text("User Info")) {
                DataRowView(title: "Age", value: age)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(age: "Unknown")
    }
}
