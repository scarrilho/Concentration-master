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
    private var currentTheme: Theme?
    private var emojiChoices: String = ""
    
    var previousCard: UIButton?
    
    var numberOfPairOfCards: Int {
        return (cardButtons.count + 1)/2
    }
    
//    private(set) var flipCount = 0 {
//        didSet {
//            updateFlipCountLabel()
//        }
//
//    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth : 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        
        let attributedString = NSAttributedString(string: "Flips = \(game.flipCount)", attributes: attributes)
        
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentTheme = getRandomtheme()
        emojiChoices = currentTheme?.icons ?? ""
        
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func newGameTapped(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairOfCards)
        currentTheme = getRandomtheme()
        emojiChoices = currentTheme?.icons ?? ""
        updateViewFromModel()
        updateFlipCountLabel()
        self.view.backgroundColor = getRandomtheme().viewBG
        
    }
    
    
    @IBAction private func touchCard(_ sender: UIButton) {

        //flipCount += 1
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
        
       // self.view.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        
        scoreLabel.text = "Score: \(game.score)"
        updateFlipCountLabel()
        
    }
    
    //private lazy var emojiChoices: String = getRandomtheme()

//    func getRandomthemeOld() -> String {
//        let themeList: [String:String] = [
//            "themeHalloween": "🎃👻🦇🙀😈👹💀👾🤡👁",
//            "themeAnimals": "🐶🐻🐼🦢🕊🐯🦁🐮🐥🐤🐔🐝🦄🦀🦓🐎",
//            "themeWeather": "🌦🌤☀️🌈⛈❄️🌬☔️☂️☃️⛄️🌩🌧",
//            "themeFood": "🍎🍏🍌🍉🍒🍓🍆🥗🍜🍙🍰🍩",
//            "themeFaces": "😆😘😍🧐😎🥳😖😢🥵🥶😵",
//            "themeTransportation": "🚘🚗🚅✈️⛵️🚁🛸🚒🏎🚓🚑🚌🚕"
//            ]
//
//        let themesKeys = Array(themeList.keys)
//        let randomKey = themesKeys[themesKeys.count.arc4random]
//
//        return themeList[randomKey]!
//
//    }
    
    private func getRandomtheme() -> Theme {
        var themeArray: [Theme] = []
        let themeHalloween = Theme(icons: "🎃👻🦇🙀😈👹💀👾🤡👁", cardBG: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), viewBG: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1))
        let themeAnimals = Theme(icons: "🐶🐻🐼🦢🕊🐯🦁🐮🐥🐤🐔🐝🦄🦀🦓🐎", cardBG: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), viewBG: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
        let themeWeather = Theme(icons: "🌦🌤☀️🌈⛈❄️🌬☔️☂️☃️⛄️🌩🌧", cardBG: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), viewBG: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1))
        let themeFood = Theme(icons: "🍎🍏🍌🍉🍒🍓🍆🥗🍜🍙🍰🍩", cardBG: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), viewBG: #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1))
        let themeFaces = Theme(icons: "😆😘😍🧐😎😖😢🤓🤪😵", cardBG: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), viewBG: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1))
        let themeTransportation = Theme(icons: "🚘🚗🚅✈️⛵️🚁🛸🚒🏎🚓🚑🚌🚕", cardBG: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), viewBG: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
        
        themeArray += [themeHalloween, themeAnimals, themeWeather, themeFood, themeFaces, themeTransportation]


        let randomTheme = themeArray[themeArray.count.arc4random]
        
        return randomTheme
        
    }
    
    //var emoji = Dictionary<Int,String>()
    private var emoji = [Card:String]()
    
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil,emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        
        return emoji[card] ?? "?"
        
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return (-Int(arc4random_uniform(UInt32(abs(self)))))
        } else {
            return 0
        }
    }
}

fileprivate struct Theme {
    let icons: String
    let cardBG: UIColor
    let viewBG: UIColor
}
