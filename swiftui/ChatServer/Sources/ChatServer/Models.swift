//
//  File.swift
//  
//
//  Created by Ataias Pereira Reis on 07/12/20.
//

import Foundation

struct SubmittedChatMessage: Decodable {
    let message: String
}

struct ReceivingChatMessage: Encodable, Identifiable {
    let date = Date()
    let id = UUID()
    let message: String
}
