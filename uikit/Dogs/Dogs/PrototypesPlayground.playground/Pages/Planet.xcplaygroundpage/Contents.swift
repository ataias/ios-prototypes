//: [Previous](@previous)

import Foundation

var json = """
{
    "name": "Earth",
    "type": "rocky",
    "standardGravity": 9.81,
    "hoursInDay": 24
}
""".data(using: .utf8)!

// Create a struct named planet

struct Planet: Codable {
    let name: String
    let type: String
    let standardGravity: Double
    let hoursInDay: Double
}

// Create a json decoder
let decoder = JSONDecoder()

// Decode in Planet

let planetResult = Result { try decoder.decode(Planet.self, from: json) }
switch planetResult {
case .success(let planet):
    print(planet)
case .failure(let error):
    print(error.localizedDescription)
}

//: [Next](@next)
