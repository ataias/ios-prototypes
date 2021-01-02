//
//  PickerViewDelegate.swift
//  Dogs
//
//  Created by Ataias Pereira Reis on 02/01/21.
//

import UIKit
import Combine

class PickerViewDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {

    let breeds: [String]
    let setter: (UIImage?) -> Void
    var cancellable: AnyCancellable?

    init(breeds: [String], setter: @escaping (UIImage?) -> Void) {
        self.breeds = breeds
        self.setter = setter
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cancellable = DogAPI.dogImagePublisher(for: breeds[row])
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("Request failed: \(String(describing: error))" )
                    case .finished:
                        print("Success")
                    }
                },
                receiveValue: { uiImage in
                    self.setter(uiImage)
                })
    }
}
