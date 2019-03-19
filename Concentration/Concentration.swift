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
    
    func chooseCard(at index: Int) {
        cards[index].isFaceUp = !cards[index].isFaceUp
    }
    
    init (numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        
        //TODO: Shuffle the cards
    }
    
}
