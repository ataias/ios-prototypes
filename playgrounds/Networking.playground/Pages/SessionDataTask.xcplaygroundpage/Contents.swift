//: [Previous](@previous)

import Foundation
import UIKit
import PlaygroundSupport

enum KittenImageLocation {
    static let http = "http://www.kittenswhiskers.com/wp-content/uploads/sites/23/2014/02/Kitten-playing-with-yarn.jpg"

    static let https = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Kitten_in_Rizal_Park%2C_Manila.jpg/460px-Kitten_in_Rizal_Park%2C_Manila.jpg"

    static let error = "not a url"
}

var varImage: UIImage?

func startLoad(urlString: String) {
    let urlOpt = URL(string: urlString)
    guard let url = urlOpt else {
        print("Invalid url: \(urlString)")
        return
    }
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        print("Completion being called!")
        if let error = error {
            print("An error occurred: \(error)")
            return
        }
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            print("Bad response: \(String(describing: response))")
            return
        }

        guard let mimeType = httpResponse.mimeType else {
            print("No mimeType")
            return
        }
        if mimeType == "image/jpeg",
           let data = data,
           let image = UIImage(data: data) {
            DispatchQueue.main.async {
                varImage = image
                print("Stored")
                print(varImage != nil)
            }
        } else {
            print("mimeType: \(mimeType)")
        }


    }

    task.resume()
    print("Called task to be resumed")
}

startLoad(urlString: KittenImageLocation.https)

func startDownload(urlString: String) {
    let urlOpt = URL(string: urlString)
    guard let url = urlOpt else {
        print("Invalid url: \(urlString)")
        return
    }
    let task = URLSession.shared.downloadTask(with: url) { url, response, error in
        print("Completion being called!")
        if let error = error {
            print("An error occurred: \(error)")
            return
        }
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            print("Bad response: \(String(describing: response))")
            return
        }

        guard let mimeType = httpResponse.mimeType else {
            print("No mimeType")
            return
        }

        guard let url = url else {
            print("Couldn't download the file")
            return
        }
        print(url)

        if mimeType == "image/jpeg",
           let data = try? Data(contentsOf: url),
           let image = UIImage(data: data) {
            DispatchQueue.main.async {
                varImage = image
                print("Stored")
                print(varImage != nil)
            }
        } else {
            print("mimeType: \(mimeType)")
        }


    }

    task.resume()
    print("Called task to be resumed")
}

startDownload(urlString: KittenImageLocation.http)
//let seconds = 4.0
//DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
//    varImage
//    print("Slept!")
//}
PlaygroundPage.current.needsIndefiniteExecution = true

//: [Next](@next)
