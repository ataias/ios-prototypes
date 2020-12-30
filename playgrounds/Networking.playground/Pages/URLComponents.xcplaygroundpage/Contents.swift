//: [Previous](@previous)

import Foundation

var urlComponents = URLComponents()
urlComponents.scheme = "https"
urlComponents.host = "itunes.apple.com"
urlComponents.path = "/us/app/udacity/id819700933"
urlComponents.queryItems = [URLQueryItem(name: "mt", value: "8")]

//if let url = urlComponents.url {
print("\(urlComponents)")
//}
//: [Next](@next)
