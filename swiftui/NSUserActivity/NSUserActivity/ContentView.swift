//
//  ContentView.swift
//  NSUserActivity
//
//  Created by Ataias Pereira Reis on 30/12/20.
//

import SwiftUI

import SwiftUI
import Intents

// Remember to add this to the NSUserActivityTypes array in the Info.plist file
let aType = "br.com.ataias.NSUserActivity.show-animal"

struct Animal: Identifiable {
    let id: Int
    let name: String
    let image: String
}

let animals = [Animal(id: 1, name: "Lion", image: "lion"),
               Animal(id: 2, name: "Fox", image: "fox"),
               Animal(id: 3, name: "Panda", image: "panda-bear"),
               Animal(id: 4, name: "Elephant", image: "elephant")]

struct ContentView: View {
    @State private var selection: Int? = nil

    var body: some View {
        NavigationView {
            List(animals) { animal in
                NavigationLink(
                    destination: AnimalDetail(animal: animal),
                    tag: animal.id,
                    selection: $selection,
                    label: { AnimalRow(animal: animal) })
            }
            .navigationTitle("Animal Gallery")
            .onContinueUserActivity(aType, perform: { userActivity in
                self.selection = Int.random(in: 0...(animals.count - 1))
            })

        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AnimalRow: View {
    let animal: Animal

    var body: some View {
        HStack {
//            Image(animal.image)
//                .resizable()
//                .frame(width: 60, height: 60)

            Text(animal.name)
        }
    }
}

struct AnimalDetail: View {
    @State private var showAddToSiri: Bool = false
    let animal: Animal

    let shortcut: INShortcut = {
        let activity = NSUserActivity(activityType: aType)
        activity.title = "Display a random animal"
        activity.suggestedInvocationPhrase = "Show Random Animal"

        return INShortcut(userActivity: activity)
    }()

    var body: some View {
        VStack(spacing: 20) {
            Text(animal.name)
                .font(.title)

//            Image(animal.image)
//                .resizable()
//                .scaledToFit()

            SiriButton(shortcut: shortcut).frame(height: 34)

            Spacer()
        }
    }
}
