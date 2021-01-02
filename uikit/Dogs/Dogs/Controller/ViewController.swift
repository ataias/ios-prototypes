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
    @IBOutlet weak var pickerView: UIPickerView!

    private var cancellable: AnyCancellable?
    private var pickerViewDelegate: PickerViewDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        // FIXME this should come from the api!
        let breeds = [
            "affenpinscher",
            "australian/shepherd",
            "buhund/norwegian",
            "bulldog/boston",
            "bulldog/english",
            "bulldog/french",
            "cairn",
        ]
        pickerViewDelegate = PickerViewDelegate(breeds: breeds) { uiImage in self.imageView.image = uiImage }
        pickerView.delegate = pickerViewDelegate
    }


}

