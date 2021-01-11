//
//  MySingletonAnalytics.swift
//  HardDependencies
//
//  Created by Ataias Pereira Reis on 11/01/21.
//

import Foundation

class MySingletonAnalytics {
    static let shared = MySingletonAnalytics()

    func track(event: String) {
        Analytics.shared.track(event: event)
        if self !== MySingletonAnalytics.shared {
            print(">> Not MySingletonAnalytics singleton")
        }
    }
}
