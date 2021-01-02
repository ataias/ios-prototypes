//
//  DogAPI.swift
//  Dogs
//
//  Created by Ataias Pereira Reis on 01/01/21.
//

import Foundation
import Combine
import UIKit

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

    struct ListBreedsResponse: Codable {
        let message: [String: [String]]
        let status: String

        var breeds: [String] {
            message.flatMap { (breed, subBreeds) -> [String] in
                if subBreeds.count == 0 {
                    return [breed]
                }
                return subBreeds.map { "\(breed)/\($0)" }
            }
        }
    }


    static func dogImagesPublisher(delayInSeconds: Double) -> AnyPublisher<UIImage?, Error> {
        let dogApiEndpoints = Timer
            .publish(every: delayInSeconds, on: .main, in: .common)
            .autoconnect()
            .map { _ in DogAPI.Endpoint.randomImageFromAllDogsCollection.url }

        let dogUrls =
            dogApiEndpoints.flatMap { URLSession.shared.dataTaskPublisher(for: $0) }
            .map { $0.data }
            .decode(type: DogAPI.Response.self, decoder: JSONDecoder())
            .compactMap { URL(string: $0.message) }

        return
            dogUrls
            .flatMap { (url:URL) in URLSession.shared.dataTaskPublisher(for: url).mapError { error -> URLError in return URLError(URLError.Code(rawValue: 404)) } }
            .map { $0.data }
            .map { UIImage(data: $0) }
            .eraseToAnyPublisher()
    }

}
