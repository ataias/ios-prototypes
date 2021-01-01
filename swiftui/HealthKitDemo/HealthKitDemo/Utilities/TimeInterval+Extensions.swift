//
//  TimeInterval+Extensions.swift
//  HealthKitDemo
//
//  Created by Ataias Pereira Reis on 01/01/21.
//

import Foundation

extension TimeInterval {
    var prettyFormat: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 1
        return formatter.string(from: self)!
    }
}
