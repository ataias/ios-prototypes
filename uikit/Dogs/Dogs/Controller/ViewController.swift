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

        let dogApiEndpoints = Timer
            .publish(every: 2.0, on: .main, in: .common)
            .autoconnect()
            .map { _ in DogAPI.Endpoint.randomImageFromAllDogsCollection.url }

        let dogUrls =
            dogApiEndpoints.flatMap { URLSession.shared.dataTaskPublisher(for: $0) }
            .map { $0.data }
            .decode(type: DogAPI.Response.self, decoder: JSONDecoder())
            .compactMap { URL(string: $0.message) }

        cancellable =
            dogUrls
            .flatMap { (url:URL) in URLSession.shared.dataTaskPublisher(for: url).mapError { error -> URLError in return URLError(URLError.Code(rawValue: 404)) } }
            .map { $0.data }
            .map { UIImage(data: $0 )}
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in print("Finished" )},
                receiveValue: { uiImage in
                    self.imageView.image = uiImage

                })
    }


}

