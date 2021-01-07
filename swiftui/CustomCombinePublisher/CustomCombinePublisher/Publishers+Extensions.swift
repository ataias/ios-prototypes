//
//  Publishers+Extensions.swift
//  CustomCombinePublisher
//
//  Created by Ataias Pereira Reis on 07/01/21.
//

import Foundation
import Combine

// Done following https://medium.com/flawless-app-stories/swift-combine-custom-publisher-6d1cc3dc248f 
extension Publishers {

    private class DataSubscription<S: Subscriber>: Subscription where S.Input == Data, S.Failure == Error {
        private let session = URLSession.shared
        private let request: URLRequest
        private var subscriber: S?

        init(request: URLRequest, subscriber: S) {
            self.request = request
            self.subscriber = subscriber
            sendRequest()
        }

        func request(_ demand: Subscribers.Demand) {
            // TODO: - Optionaly Adjust The Demand
        }

        func cancel() {
            subscriber = nil
        }

        private func sendRequest() {
            guard let subscriber = subscriber else { return }
            session.dataTask(with: request) { (data, _, error) in
                _ = data.map(subscriber.receive)
                _ = error.map { subscriber.receive(completion: Subscribers.Completion.failure($0)) }
            }.resume()
        }
    }

    struct DataPublisher: Publisher {
        typealias Output = Data
        typealias Failure = Error

        private let urlRequest: URLRequest

        init(urlRequest: URLRequest) {
            self.urlRequest = urlRequest
        }

        func receive<S: Subscriber>(subscriber: S) where
            DataPublisher.Failure == S.Failure, DataPublisher.Output == S.Input {
            let subscription = DataSubscription(request: urlRequest, subscriber: subscriber)
            subscriber.receive(subscription: subscription)
        }
    }

}
