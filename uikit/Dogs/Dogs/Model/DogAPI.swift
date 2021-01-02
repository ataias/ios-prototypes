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
    enum Endpoint {
        case randomImageFromAllDogsCollection
        case randomImageFromBreed(breed: String)
        case dogBreedList

        var url: URL {
            URL(string: stringValue)!
        }

        var stringValue: String {
            switch self {
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageFromBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .dogBreedList:
                return "https://dog.ceo/api/breeds/list/all"
            }
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
        let url = Self.Endpoint.randomImageFromAllDogsCollection.url
        let dogApiEndpoints = Timer
            .publish(every: delayInSeconds, on: .main, in: .common)
            .autoconnect()
            .map { _ in url }

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

    static func dogImagePublisher(for breed: String) -> AnyPublisher<UIImage?, Error> {
        let url = Self.Endpoint.randomImageFromBreed(breed: breed).url
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: DogAPI.Response.self, decoder: JSONDecoder())
            .compactMap { URL(string: $0.message) }
            .flatMap { (url:URL) in URLSession.shared.dataTaskPublisher(for: url).mapError { error -> URLError in return URLError(URLError.Code(rawValue: 404)) } }
            .map { $0.data }
            .map { UIImage(data: $0) }
            .eraseToAnyPublisher()
    }

    static func breedListPublisher() -> AnyPublisher<[String], Error> {
        let url = Self.Endpoint.dogBreedList.url
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: DogAPI.ListBreedsResponse.self, decoder: JSONDecoder())
            .map { $0.breeds.sorted() }
            .eraseToAnyPublisher()
    }

}
