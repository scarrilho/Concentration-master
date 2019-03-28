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
    private var emojiChoices: String = "?"
    
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
        self.view.backgroundColor = currentTheme?.viewBG
        updateViewFromModel()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentTheme = getRandomtheme()
        emojiChoices = currentTheme?.icons ?? "?"

        
        
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
        emojiChoices = currentTheme?.icons ?? "?"
        updateViewFromModel()
        updateFlipCountLabel()
        self.view.backgroundColor = currentTheme?.viewBG
        
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
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 0) : currentTheme?.cardBG
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
        let themeHalloween = Theme(icons: "🎃👻🦇🙀😈👹💀👾🤡👁", cardBG: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), viewBG: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        let themeAnimals = Theme(icons: "🐶🐻🐼🦢🕊🐯🦁🐮🐥🐤🐔🐝🦄🦀🦓🐎", cardBG: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), viewBG: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1))
        let themeWeather = Theme(icons: "🌦🌤☀️🌈⛈❄️🌬☔️☂️☃️⛄️🌩🌧", cardBG: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), viewBG: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
        let themeFood = Theme(icons: "🍎🍏🍌🍉🍒🍓🍆🥗🍜🍙🍰🍩", cardBG: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), viewBG: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        let themeFaces = Theme(icons: "😆😘😍🧐😎😖😢🤓🤪😵", cardBG: #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1), viewBG: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
        let themeTransportation = Theme(icons: "🚘🚗🚅✈️⛵️🚁🛸🚒🏎🚓🚑🚌🚕", cardBG: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), viewBG: #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))
        
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
