//
//  InstancePropertyViewController.swift
//  HardDependencies
//
//  Created by Ataias Pereira Reis on 11/01/21.
//

import UIKit

class InstancePropertyViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.shared.track(event: "\(#function) - \(type(of: self))")
    }

}
