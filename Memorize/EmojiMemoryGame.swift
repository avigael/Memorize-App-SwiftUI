//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Gael on 9/24/21.
//

import SwiftUI

// VIEWMODEL
class EmojiMemoryGame: ObservableObject {
    static func createMemoryGame(pairs: Int, emojis: [String]) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: pairs) { pairIndex in emojis[pairIndex]}
    }
    
    static func initializeThemes() -> MemoryGameTheme<String> {
        MemoryGameTheme<String>(
            name: "Yellow Theme",
            themeContent: ["😀","😃","😄","😁","😆","😅","😂","🤣","🥲","☺️"],
            numOfPairs: 8,
            color: (1.0, 0.8, 0)
        )
    }
    
    @Published private var model: MemoryGame<String>
    var themeModel: MemoryGameTheme<String>
    
    init() {
        // Initialize theme first
        themeModel = EmojiMemoryGame.initializeThemes()
        // Set up game
        model = EmojiMemoryGame.createMemoryGame(pairs: themeModel.theme.numOfPairs, emojis: themeModel.theme.themeContent.shuffled())
        // Add more themes
        themeModel.addTheme(name: "Blue Theme", themeContent: ["💙", "🦋", "🥶", "🧢", "🚙", "🥏", "🔵", "🎽"], numOfPairs: 10, color: (0, 0, 1.0))
        themeModel.addTheme(name: "Green Theme", themeContent: ["💚", "✅", "🔫", "🍀", "🐍", "🐸", "🥑", "🐢"], numOfPairs: 8, color: (0, 1.0, 0.2))
        themeModel.addTheme(name: "Red Theme", themeContent: ["❤️", "🎁", "💥", "👹", "👺", "🚗", "🌶"], numOfPairs: 7, color: (1.0, 0, 0))
        themeModel.addTheme(name: "Pink Theme", themeContent: ["💕", "💗", "💖", "💞", "💓", "🌸"], numOfPairs: 6, color: (1.0, 0, 1.0))
        themeModel.addTheme(name: "Orange Theme", themeContent: ["🧡", "🍑", "🍊", "🎃", "🥕"], numOfPairs: 5, color: (1.0, 0.5, 0))
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    var theme: MemoryGameTheme<String>.Theme {
        themeModel.theme
    }
    
    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    // Needs to set a random theme
    func createNewGame() {
        let randomThemeIndex = Int.random(in: 0..<themeModel.themes.count)
        themeModel.pickTheme(atIndex: randomThemeIndex)
        model = EmojiMemoryGame.createMemoryGame(pairs: themeModel.theme.numOfPairs, emojis: themeModel.theme.themeContent.shuffled())
    }
    func chooseTheme(_ num: Int) {
        themeModel.pickTheme(atIndex: num)
        model = EmojiMemoryGame.createMemoryGame(pairs: themeModel.theme.numOfPairs, emojis: themeModel.theme.themeContent.shuffled())
    }
}
