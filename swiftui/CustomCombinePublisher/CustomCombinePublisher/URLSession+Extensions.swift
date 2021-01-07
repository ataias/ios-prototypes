//
//  URLSession+Extensions.swift
//  CustomCombinePublisher
//
//  Created by Ataias Pereira Reis on 07/01/21.
//

import Foundation
import Combine

extension URLSession {
    func dataResponse(for request: URLRequest) -> Publishers.DataPublisher {
        return Publishers.DataPublisher(urlRequest: request)
    }
}
