//
//  Models.swift
//  SwiftChat
//
//  Created by Ataias Pereira Reis on 07/12/20.
//

import Foundation

struct SubmittedChatMessage: Encodable {
    let message: String
}

struct ReceivingChatMessage: Decodable, Identifiable {
    let date: Date
    let id: UUID
    let message: String
}

// TODO continue tutorial
// https://medium.com/@frzi/a-simple-chat-app-with-swiftui-and-websockets-or-swift-in-the-back-swift-in-the-front-78b34c3dc912
// look for "Notice how the Encodable and Decodable protocols have been swapped" and continue from there
