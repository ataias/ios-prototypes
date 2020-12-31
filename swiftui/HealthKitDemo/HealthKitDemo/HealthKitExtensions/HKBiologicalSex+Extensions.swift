//
//  HKBiologicalSex+Extensions.swift
//  HealthKitDemo
//
//  Created by Ataias Pereira Reis on 31/12/20.
//

import HealthKit

extension HKBiologicalSex: CustomStringConvertible {

    public var description: String {
        switch self {
        case .notSet: return "Unknown"
        case .female: return "Female"
        case .male: return "Male"
        case .other: return "Other"
        @unknown default:
            // TODO what about debugging and showing as unknown with a warning icon the user can complain to support later?
            fatalError("Unhandled type!")
        }
    }
}
