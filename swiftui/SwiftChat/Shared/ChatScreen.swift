//
//  ChatScreen.swift
//  SwiftChat
//
//  Created by Ataias Pereira Reis on 07/12/20.
//

import SwiftUI

struct ChatScreen: View {
    @StateObject private var model = ChatScreenModel()
    @State private var message = ""

    var body: some View {
        VStack {
            // Chat history.
            ScrollView { // 1
                // Coming soon!
            }

            // Message field.
            HStack {
                TextField("Message", text: $message) // 2
                    .padding(10)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(5)

                Button(action: {}) { // 3
                    Image(systemName: "arrowshape.turn.up.right")
                        .font(.system(size: 20))
                }
                .padding()
                .disabled(message.isEmpty) // 4
            }
            .padding()
        }
        .onAppear(perform: onAppear)
        .onDisappear(perform: onDisappear)
    }

    private func onAppear() {
        model.connect()
    }
    private func onDisappear() {
        model.disconnect()
    }
}
