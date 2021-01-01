//
//  DogAPI.swift
//  Dogs
//
//  Created by Ataias Pereira Reis on 01/01/21.
//

import Foundation
import Combine

class DogAPI {
    enum Endpoint: String, CaseIterable {
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"

        var url: URL {
            return URL(string: self.rawValue)!
        }
    }

    struct Response: Codable {
        let message: String
        let status: String
    }

}
