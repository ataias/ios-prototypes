//
//  DogAPI.swift
//  Dogs
//
//  Created by Ataias Pereira Reis on 01/01/21.
//

import Foundation

class DogAPI {
    enum Endpoint: String {
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"

        var url: URL {
            return URL(string: self.rawValue)!
        }
    }
}
