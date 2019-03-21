//
//  ViewController.swift
//  Concentration
//
//  Created by sergio on 2019/03/13.
//  Copyright © 2019 Sergio Carrilho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairOfCards)
    
    var numberOfPairOfCards: Int {
        return (cardButtons.count + 1)/2
    }
    
    private(set) var flipCount = 0 {didSet {flipCountLabel.text = "Flip count = \(flipCount)"}}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    

    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            //print("Card number: \(cardNumber)")
        } else {
            print("Chosen card was not in cardButtons")
        }
        
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 0) : #colorLiteral(red: 1, green: 0.5745739937, blue: 0.001978197834, alpha: 1)
            }
            
        }
    }
    
    private var emojiChoices: [String] = ["🎃", "👻", "🦇","🙀","😈","👹","💩", "💀", "👾", "☠️"]
    
    //var emoji = Dictionary<Int,String>()
    private var emoji = [Int:String]()
    
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil,emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
//        if emoji[card.identifier] != nil {
//            return emoji[card.identifier]!
//        } else {
//            return "?"
//        }
        return emoji[card.identifier] ?? "?"
        
    }
    
}

