//
//  ContentView.swift
//  NLTagger
//
//  Created by Ataias Pereira Reis on 28/12/20.
//

import SwiftUI
import NaturalLanguage

struct ContentView: View {
    private let strings: [String] = [
        "I love cheese",
        "Hacking with Swift is awesome. I learn lots of stuff there.",
        "Hacking with Swift is awesome",
        "It sucks to be a sucker",
    ]

    var body: some View {
        List {
            ForEach(strings, id: \.self) { str in
                HStack {
                    Text("\(str.sentiment)")
                    Text("\(str)")
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension String {

    var sentiment: Double {
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = self
        let (sentiment, _) = tagger.tag(at: self.startIndex, unit: .paragraph, scheme: .sentimentScore)
        return Double(sentiment?.rawValue ?? "0") ?? 0
    }
}
