//
//  DataRowView.swift
//  HealthKitDemo
//
//  Created by Ataias Pereira Reis on 31/12/20.
//

import SwiftUI

struct DataRowView: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundColor(Color.gray)
        }
    }
}

struct DataRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Form {
                DataRowView(title: "Age", value: "21")
            }
            .frame(width: 428, height: 100, alignment: .center)
            .previewLayout(.sizeThatFits)
            Form {
                DataRowView(title: "Age", value: "21")
            }
            .preferredColorScheme(.dark)
            .frame(width: 428, height: 100, alignment: .center)
            .previewLayout(.sizeThatFits)
        }
    }
}
