//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Gael on 9/13/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
