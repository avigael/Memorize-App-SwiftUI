//
//  MemoryGame.swift
//  Memorize
//
//  Created by Gael on 9/24/21.
//

import Foundation

// GAME MODEL
struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    private(set) var score: Int
    private var indexOfFaceUpCard: Int?
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    if cards[chosenIndex].hasFlipped || cards[potentialMatchIndex].hasFlipped {
                        score -= 1
                    } else {
                        cards[chosenIndex].hasFlipped = true
                        cards[potentialMatchIndex].hasFlipped = true
                    }
                    
                }
                indexOfFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }

    init(numberOfPairsOfCards: Int, creatCardContent: (Int) -> CardContent) {
        cards = []
        score = 0
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = creatCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards = cards.shuffled()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var hasFlipped = false
        var content: CardContent
        var id: Int
    }
}
