//
//  PickerViewDelegate.swift
//  Dogs
//
//  Created by Ataias Pereira Reis on 02/01/21.
//

import UIKit
import Combine
import os

class PickerViewDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {

    let breeds: [String]
    let setter: (UIImage?) -> Void
    var cancellable: AnyCancellable?
    let defaultLog = Logger()

    init(breeds: [String], setter: @escaping (UIImage?) -> Void) {
        self.breeds = breeds
        self.setter = setter

        super.init()
        fetchImage(for: breeds[0])
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
        fetchImage(for: breeds[row])
    }

    private func fetchImage(for breed: String) {
        cancellable = DogAPI.dogImagePublisher(for: breed)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        self.defaultLog.error("Request failed: \(String(describing: error))" )
                    case .finished:
                        self.defaultLog.info("Success")
                    }
                },
                receiveValue: { uiImage in
                    self.setter(uiImage)
                })
    }
}
