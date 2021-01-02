//: [Previous](@previous)

import Foundation


let encoder = JSONEncoder()
encoder.dateEncodingStrategy = .iso8601

let data = try encoder.encode(Date())
print(String(data: data, encoding: .utf8)!)

//: [Next](@next)
