//
//  TextView.swift
//  ClickWordsDemo
//
//  Created by Ataias Pereira Reis on 03/01/21.
//

import SwiftUI

class MyUITextView: UITextView, UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print(URL)

        // When False: does not open URL in external program (i.e. browser or another handler)
        return false
    }
}

struct TextView: UIViewRepresentable {
    @Binding var text: NSAttributedString

    // TODO some problems with NSAttributedString...
    // 1. No automatic dark mode
    // 2. Default Styling is different from the default "Text" SwiftUI View
    // 3. For the idea of making words clickable to access a dictionary: I would need some hack to indicate a link is just a callback; maybe a bogus link with the word name and that's it... I would need to get rid the link styles too, otherwise they would be in the whole text
    func makeUIView(context: Context) -> MyUITextView {
        let view = MyUITextView()

        view.dataDetectorTypes = .link
        view.isEditable        = false
        view.isSelectable      = true
        view.delegate          = view
        // Removing the link text attributes, links don't become blue anymore! The style from the original NSattributedText is preserved!
        view.linkTextAttributes = [:]

        return view
    }

    func updateUIView(_ uiView: MyUITextView, context: Context) {
        uiView.attributedText = text
    }
}
