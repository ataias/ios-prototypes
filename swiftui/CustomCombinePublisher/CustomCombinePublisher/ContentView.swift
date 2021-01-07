//
//  ContentView.swift
//  CustomCombinePublisher
//
//  Created by Ataias Pereira Reis on 07/01/21.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var cancellable: AnyCancellable?
    @State private var image: Image?

    var body: some View {
        VStack {
            image
            Text("Hello, world!")
                .padding()
        }
        .onAppear(perform: getImage)
    }

    func getImage() {
        let url = URL(string: "https://images.dog.ceo/breeds/collie-border/n02106166_18.jpg")!

        let urlRequest = URLRequest(url: url)

        cancellable = URLSession.shared.dataResponse(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .finished:
                        print("Success")
                    }
                },
                receiveValue: { (data: Data) in
                    if let uiImage = UIImage(data: data) {
                        image = Image(uiImage: uiImage)
                    } else {
                        print("Failure!")
                    }
                }
            )
    }
}

struct DogResponse {
    let message: String
    let status: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
