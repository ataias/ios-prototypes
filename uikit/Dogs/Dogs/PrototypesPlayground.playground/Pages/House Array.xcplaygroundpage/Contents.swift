//: [Previous](@previous)

import Foundation

let jsonData = """
[
    {
        "type": "colonial",
        "location": "Plainville, MA",
        "bedrooms": 3,
        "bathrooms": 2.5,
        "has_air_conditioning": false,
        "amenities": ["basemenet", "something"],
        "listing": {
            "price": 43000.50,
            "date": "2021-01-02T11:46:23Z",
        }
    },
    {
        "type": "different",
        "location": "Florianópolis",
        "bedrooms": 1,
        "bathrooms": 1,
        "has_air_conditioning": true,
        "amenities": ["varanda", "something"],
        "listing": {
            "price": 99000.50,
            "date": "2020-01-02T11:46:23Z",
        },
    }
]
""".data(using: .utf8)!

struct House: Codable {
    let type: String
    let location: String
    let bedrooms: Int
    let bathrooms: Double
    let hasAirConditioning: Bool
    let amenities: [String]
    let listing: Listing

    struct Listing: Codable {
        let price: Double
        let date: Date
    }
}

let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601
decoder.keyDecodingStrategy = .convertFromSnakeCase
let houses = try decoder.decode([House].self, from: jsonData)
for house in houses {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    encoder.outputFormatting = .prettyPrinted
    let data = try! encoder.encode(house)
    print(String(data: data, encoding: .utf8)!)
}
//: [Next](@next)
