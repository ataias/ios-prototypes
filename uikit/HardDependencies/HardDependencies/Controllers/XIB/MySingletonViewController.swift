//
//  MySingletonViewController.swift
//  HardDependencies
//
//  Created by Ataias Pereira Reis on 11/01/21.
//

import UIKit

class MySingletonViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        MySingletonAnalytics.shared.track(event: "\(#function) - \(type(of: self))")
    }

}
