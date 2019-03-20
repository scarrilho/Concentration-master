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
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        //cards[index].isFaceUp = !cards[index].isFaceUp

        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[index].identifier == cards[matchIndex].identifier {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                //Either no cards face up or two cards face up
                for flipIndex in cards.indices {
                    cards[flipIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
    
    init (numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        
        //TODO: Shuffle the cards
        cards.shuffle()
    }
    
}
