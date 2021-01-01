//
//  ViewController.swift
//  Dogs
//
//  Created by Ataias Pereira Reis on 01/01/21.
//

import UIKit
import Combine
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    private var cancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()

        cancellable =
            DogAPI.dogImagesPublisher(delayInSeconds: 1.5)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { error in print("Request failed: \(String(describing: error))" )},
                receiveValue: { uiImage in
                    self.imageView.image = uiImage
                })

    }


}

