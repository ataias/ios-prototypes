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

        let url = DogAPI.Endpoint.randomImageFromAllDogsCollection.url
        let dogUrls: AnyPublisher<URL, Error> = URLSession.shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: DogAPI.Response.self, decoder: JSONDecoder())
            .compactMap { URL(string: $0.message) }
            .eraseToAnyPublisher()

        cancellable =
            dogUrls
            .flatMap { (url:URL) in URLSession.shared.dataTaskPublisher(for: url).mapError { error -> URLError in return URLError(URLError.Code(rawValue: 404)) } }
            .map { $0.data }
            .map { UIImage(data: $0 )}
            .sink(
                receiveCompletion: { _ in print("Finished" )},
                receiveValue: { uiImage in
                    DispatchQueue.main.async {
                        self.imageView.image = uiImage
                    }

                })
    }


}

