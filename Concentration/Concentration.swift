//
//  Concentration.swift
//  Concentration
//
//  Created by sergio on 2019/03/19.
//  Copyright © 2019 Sergio Carrilho. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = Array<Card>()
    
    private var cardsShown: [Int] = []
    private(set) var flipCount = 0
    
    private(set) var score: Int = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp}.oneAndOnly

        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {

        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards")
    
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[index] == cards[matchIndex] {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    score += 2
                } else {//Cards didn't match
                    if isIndexInCardShownArray(cardIndex: matchIndex) {score -= 1}
                    if isIndexInCardShownArray(cardIndex: index) {score -= 1}
                    
                }
                cards[index].isFaceUp = true
            } else {
                //Either no cards face up or two cards face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
        //print("Score : \(score)")
        
    }
    
    private mutating func isIndexInCardShownArray(cardIndex: Int) -> Bool {
        if let _ = cardsShown.firstIndex(of: cardIndex) {
            return true
        } else {
            cardsShown.append(cardIndex)
            return false
        }
    }
    
    init (numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must at least have one pair of cards")
        
        score = 0
        flipCount = 0
        cardsShown = []
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        
        cards.shuffle()
    }
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
