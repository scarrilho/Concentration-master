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
    var timeAtFirstTap: Date?
 
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
                    
                    //Capture time for second tap and calculate score for matching cards: let elapsed = Date().timeIntervalSince(timeAtPress)
                    if timeAtFirstTap != nil {
                        let elapsed = Double(Date().timeIntervalSince(timeAtFirstTap!))
                        
                        if (elapsed < 0.5) {
                            score += 1
                            //print("Quick Move = \(elapsed)")
                        } else {
                            //do nothing
                            //print("Slow Move = \(elapsed)")
                        }
                        
                    }
                    
                } else {//Cards didn't match
                    if isIndexInCardShownArray(cardIndex: matchIndex) {score -= 1}
                    if isIndexInCardShownArray(cardIndex: index) {score -= 1}
                }
                cards[index].isFaceUp = true
            } else {
                //Either no cards face up or two cards face up
                indexOfOneAndOnlyFaceUpCard = index
                //Capture time of first tap here
                timeAtFirstTap = Date()
            }
        }
        
        //print("Score : \(score)")
        
    }
    
    //Return points based on the speed to match two cards
    private func scorePointsByTime(elapsed: Double) -> Double {
        if (elapsed < 0.5) {
            return 1
        } else if (elapsed < 1){
            return 0.5
        } else {
        return 0
        }
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
