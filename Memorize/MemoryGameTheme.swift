//
//  MemoryGameTheme.swift
//  Memorize
//
//  Created by Gael on 9/26/21.
//

import Foundation

// THEME MODEL
struct MemoryGameTheme<CardContent> where CardContent: Equatable {
    private(set) var themes: Array<Theme>
    private(set) var theme: Theme
    mutating func pickTheme(atIndex index: Int) {
        theme = themes[index]
    }
    
    mutating func addTheme(name: String, themeContent: [CardContent], numOfPairs: Int, color: (red: Double, green: Double, blue: Double)) {
        var checkedPairs = numOfPairs
        if numOfPairs > themeContent.count {
            checkedPairs = themeContent.count
        }
        themes.append(Theme(name: name, themeContent: themeContent, numOfPairs: checkedPairs, color: RGB(red: color.red, green: color.green, blue: color.blue)))
    }
    
    init(name: String, themeContent: [CardContent], numOfPairs: Int, color: (red: Double, green: Double, blue: Double)) {
        themes = []
        themes.append(Theme(name: name, themeContent: themeContent, numOfPairs: numOfPairs, color: RGB(red: color.red, green: color.green, blue: color.blue)))
        theme = themes[0]
    }
    
    struct Theme {
        var name: String
        var themeContent: [CardContent]
        var numOfPairs: Int
        var color: RGB
    }
    
    struct RGB {
        var red: Double
        var green: Double
        var blue: Double
    }
}
