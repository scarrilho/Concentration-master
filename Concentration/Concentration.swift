//
//  Concentration.swift
//  Concentration
//
//  Created by sergio on 2019/03/19.
//  Copyright © 2019 Sergio Carrilho. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = Array<Card>()
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        //cards[index].isFaceUp = !cards[index].isFaceUp
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[index].identifier == cards[matchIndex].identifier {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                //Either no cards face up or two cards face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
    
    init (numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        
        cards.shuffle()
    }
    
}
