//
//  Card.swift
//  Concentration
//
//  Created by sergio on 2019/03/17.
//  Copyright © 2019 Sergio Carrilho. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init () {
        self.identifier = Card.getUniqueIdentifier()
        
    }
    
}
