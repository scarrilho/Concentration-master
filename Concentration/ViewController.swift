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
    
    @IBOutlet private weak var scoreLabel: UILabel! {
        didSet {
            //updateScoreLabels()
            updateUILabels()
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            //updateFlipCountLabel()
            updateUILabels()
        }
    }

    private func updateUILabels() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth : 5.0,
            //.strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            .strokeColor: currentTheme?.cardBG ??  #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)//same color as card background
        ]

        if (flipCountLabel != nil) {
            let labelAttributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
            flipCountLabel.attributedText = labelAttributedString
        }
        
        if  (scoreLabel != nil) {
            let scoreAttributedString = NSAttributedString(string: "Score: \(game.score)", attributes: attributes)
            scoreLabel.attributedText = scoreAttributedString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentTheme = getRandomtheme()
        emojiChoices = currentTheme?.icons ?? ""
        self.view.backgroundColor = currentTheme?.viewBG ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        updateViewFromModel()

        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func newGameTapped(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairOfCards)
        currentTheme = getRandomtheme()
        emojiChoices = currentTheme?.icons ?? "?"
        updateViewFromModel()
        
        updateUILabels()

        self.view.backgroundColor = currentTheme?.viewBG
    }
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
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
        
        updateUILabels()
        
    }
    
    private func getRandomtheme() -> Theme {
        var themeArray: [Theme] = []
        let themeHalloween = Theme(icons: "🎃👻🦇🙀😈👹💀👾🤡👁", cardBG: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), viewBG: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        let themeAnimals = Theme(icons: "🐶🐻🐼🦢🕊🐯🦁🐮🐥🐤🐔🐝🦄🦀🦓🐎", cardBG: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), viewBG: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        let themeWeather = Theme(icons: "🌦🌤☀️🌈⛈❄️🌬☔️☂️☃️⛄️🌩🌧", cardBG: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), viewBG: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
        let themeFood = Theme(icons: "🍎🍏🍌🍉🍒🍓🍆🥗🍜🍙🍰🍩", cardBG: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), viewBG: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        let themeFaces = Theme(icons: "😆😘😍🧐😎😖😢🤓🤪😵", cardBG: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), viewBG: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        let themeTransportation = Theme(icons: "🚘🚗🚅✈️⛵️🚁🛸🚒🏎🚓🚑🚌🚕", cardBG: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), viewBG: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        
        themeArray += [themeHalloween, themeAnimals, themeWeather, themeFood, themeFaces, themeTransportation]


        let randomTheme = themeArray[themeArray.count.arc4random]
        
        return randomTheme
    }
    
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
