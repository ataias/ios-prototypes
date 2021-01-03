//
//  ContentView.swift
//  ClickWordsDemo
//
//  Created by Ataias Pereira Reis on 03/01/21.
//

import SwiftUI

struct ContentView: View {
    @State private var text: NSAttributedString = {
        let plainAttributedString = NSMutableAttributedString(string: "This is a link: ", attributes: nil)
        let string = "A link to Google"
        let attributedLinkString = NSMutableAttributedString(string: string, attributes:[NSAttributedString.Key.link: URL(string: "http://www.google.com")!])
        let fullAttributedString = NSMutableAttributedString()
        fullAttributedString.append(plainAttributedString)
        fullAttributedString.append(attributedLinkString)
        return fullAttributedString
    }()

    let longSentence = "The brown fox jumps over something. The brown fox jumps over something. The brown fox jumps over something. The brown fox jumps over something. The brown fox jumps over something. The brown fox jumps over something."

    static let someHtml = """
        <style type="text/css">
          #red {
            color: #f00;
          }
          #green {
            color: #0f0;
          }
          #blue {
            color: #00f;
            font-weight: Bold;
            font-size: 32;
          }</style
        ><span id="red">Red,</span><span id="green"> Green </span
        ><span id="blue">and Blue</span
        ><a id="red" href="https://www.w3schools.com/"
          >Visit W3Schools.com!</a
        >
    """.html2AttStr

    @State private var htmlAttributedText = { () -> NSAttributedString in
        let attr = NSMutableAttributedString(attributedString: someHtml!)
//        let range = NSMakeRange(0, attr.string.count)
//        attr.removeAttribute(.attachment, range: range)
//        attr.removeAttribute(.link, range: range)
//        attr.removeAttribute(.foregroundColor, range: range)
//        attr.removeAttribute(.underlineStyle, range: range)
//        attr.addAttribute(.attachment, value: UIColor.green, range: range)
//        attr.addAttribute(.link, value: UIColor.black, range: range)
//        attr.addAttribute(.foregroundColor, value: UIColor.green, range: range)
        return attr
    }()

    var words: [IdentifiedWord] {
        longSentence
            .split(separator: " ")
            .enumerated()
            .map { (n, word) in
                IdentifiedWord(id: n, word: String(word))
            }
    }

    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
            TextView(text: $text)
            HStack {
                // FIXME Ideally, we could have the words positioned inside some container and that would make them look like any other long text, but this does not work... it breaks as it spills over the next line
                ForEach(words) { identifiedWord in
                    Text(identifiedWord.word)
                }
            }
            // this is actually nice; I could get the text to be styled in HTML, even getting rid of the link style...
            TextView(text: $htmlAttributedText)

        }
    }
}

extension String {
    var html2AttStr: NSAttributedString? {
        let data = self.data(using: .utf8)!
        return try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
    }
}

struct IdentifiedWord: Identifiable {
    let id: Int
    let word: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
