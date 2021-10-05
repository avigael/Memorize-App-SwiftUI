//
//  ContentView.swift
//  Memorize
//
//  Created by Gael on 9/13/21.
//

import SwiftUI

// VIEW
struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        VStack {
            themeButtons
            Text(viewModel.theme.name)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            Text("Score: \(viewModel.score)")
            Spacer()
            newGameButton
        }
        .foregroundColor(Color(red: viewModel.theme.color.red, green: viewModel.theme.color.green, blue: viewModel.theme.color.blue))
        .font(.largeTitle)
        .padding(.horizontal)
    }
    var themeButtons: some View {
        HStack{
            Button(action: {
                viewModel.chooseTheme(0)
            }) {
                Image(systemName: "1.circle")
            }
            Button(action: {
                viewModel.chooseTheme(1)
            }) {
                Image(systemName: "2.circle")
            }
            Button(action: {
                viewModel.chooseTheme(2)
            }) {
                Image(systemName: "3.circle")
            }
            Button(action: {
                viewModel.chooseTheme(3)
            }) {
                Image(systemName: "4.circle")
            }
            Button(action: {
                viewModel.chooseTheme(4)
            }) {
                Image(systemName: "5.circle")
            }
            Button(action: {
                viewModel.chooseTheme(5)
            }) {
                Image(systemName: "6.circle")
            }
        }
    }
    var newGameButton: some View {
        Button(action: {
            viewModel.createNewGame()
        }) {
            Text("NEW GAME")
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content)
            } else if card.isMatched{
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}
