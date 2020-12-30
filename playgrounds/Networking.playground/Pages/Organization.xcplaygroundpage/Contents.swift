//: [Previous](@previous)

import Foundation

enum GoogleSearch {
    static let scheme = "https"
    static let host = "google.com"
    static let path = "/search"
    static let queryName = "query"
    static let udacitySearchTerm = "udacity"
}

var components = URLComponents()

components.scheme = GoogleSearch.scheme
components.host = GoogleSearch.host
components.path = GoogleSearch.path
components.queryItems = [URLQueryItem(name: GoogleSearch.queryName, value: GoogleSearch.udacitySearchTerm)]

print(components.url!)

//: [Next](@next)
