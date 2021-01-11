//
//  Analytics.swift
//  HardDependencies
//
//  Created by Ataias Pereira Reis on 11/01/21.
//

import Foundation

class Analytics {
    static let shared = Analytics()

    func track(event: String) {
        print(">> \(event)")

        if self !== Self.shared {
            print(">> ...Not the analytics singleton")
        }
    }
}
