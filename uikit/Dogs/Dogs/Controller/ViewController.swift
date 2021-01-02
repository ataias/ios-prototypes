//
//  ViewController.swift
//  Dogs
//
//  Created by Ataias Pereira Reis on 01/01/21.
//

import UIKit
import Combine
import Foundation
import os

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!

    private var cancellable: AnyCancellable?
    private var pickerViewDelegate: PickerViewDelegate!

    let defaultLog = Logger()

    override func viewDidLoad() {
        super.viewDidLoad()

        cancellable = DogAPI.breedListPublisher()
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.defaultLog.error("Error occurred: \(error.localizedDescription)")
                case .finished:
                    self.defaultLog.info("Success")
                }
            } receiveValue: { breeds in
                self.pickerViewDelegate = PickerViewDelegate(breeds: breeds) { uiImage in self.imageView.image = uiImage }
                self.pickerView.delegate = self.pickerViewDelegate
                // pickerView.reloadAllComponents was not needed; probably because I just assign the delegate after creating it?
            }
    }


}

