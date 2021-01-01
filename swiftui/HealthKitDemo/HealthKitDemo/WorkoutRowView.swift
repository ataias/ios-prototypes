//
//  WorkoutRowView.swift
//  HealthKitDemo
//
//  Created by Ataias Pereira Reis on 01/01/21.
//

import SwiftUI

struct WorkoutData: Identifiable {
    let id: UUID
    let date: Date
    let activityType: String
    let duration: TimeInterval

    static func getSample() -> WorkoutData {
        return WorkoutData(id: UUID(), date: Date(), activityType: "Bowling", duration: 60.0*50)
    }
}

struct WorkoutRowView: View {
    let workoutData: WorkoutData

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(workoutData.activityType).bold()
                Text("\(workoutData.date)")
            }
            Spacer()
            Text("\(workoutData.duration)")
                .foregroundColor(Color.gray)
        }
    }
}

struct WorkoutRowView_Previews: PreviewProvider {
    static let workoutData = WorkoutData.getSample()
    static var previews: some View {
        Form {
            WorkoutRowView(workoutData: workoutData)
        }
    }
}
