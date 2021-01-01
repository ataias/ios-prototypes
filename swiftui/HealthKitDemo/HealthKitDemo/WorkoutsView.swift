//
//  WorkoutsView.swift
//  HealthKitDemo
//
//  Created by Ataias Pereira Reis on 01/01/21.
//

import SwiftUI

struct WorkoutsView: View {
    let workouts: [WorkoutData]
    var body: some View {
        Section(header: Text("Workouts")) {
            ForEach(workouts) { workout in
                WorkoutRowView(workoutData: workout)
            }

        }
    }
}

struct WorkoutsView_Previews: PreviewProvider {
    static let workoutData: [WorkoutData] = (1...10).map { _ in
        WorkoutData.getSample()
    }
    static var previews: some View {
        Form {
            WorkoutsView(workouts: workoutData)
        }
    }
}
