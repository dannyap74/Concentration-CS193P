//
//  ViewController.swift
//  Concentration
//
//  Created by Даниил Палеев on 02.01.2020.
//  Copyright © 2020 Даниил Палеев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairOfCards: (cardButtons.count + 1)/2)
    
    var flipCount: Int = 0 {
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var score = 0 {
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        game = Concentration(numberOfPairOfCards: (cardButtons.count + 1)/2)
        themeIndex = Int(arc4random_uniform(UInt32(Themes.count)))
        flipCount = 0
        score = 0
        
        updateViewFromModel()
    }
    
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    // MARK: Handle touch card behaviour
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        let cardNumber = cardButtons.index(of: sender)!
        game.chooseCard(at: cardNumber)
        score = game.score
        flipCount = game.flips
        updateViewFromModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeIndex = Int(arc4random_uniform(UInt32(Themes.count)))
        updateViewFromModel()
    }
    
    var themeIndex = 0
    {
        didSet {
            emojiChoices = Themes[themeIndex].emoji
            view.backgroundColor = Themes[themeIndex].backgroundColor
            cardColor = Themes[themeIndex].cardColor
            newGameButton.setTitleColor(cardColor, for: .normal)
            flipCountLabel.textColor = cardColor
            scoreLabel.textColor = cardColor
        }
    }
    
    var emojiChoices = [String]()
    var cardColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFacedUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor =  card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : cardColor
            }
            
        }
    }
    
    // MARK: Chosing emoji
    
    var emoji = [Int:String] ()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0  {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
    // TODO: add more themes
    
    var Themes: [Theme] = [
        Theme(name: "Halloween", emoji: ["👻", "🎃", "😱", "😵", "😈", "👺", "🤡", "🤖", "☠️", "👽"], backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cardColor: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)),
        Theme(name: "Animals", emoji: ["🐶", "🐭", "🦊", "🦋", "🐢", "🐸", "🐵", "🐞", "🐿", "🐇", "🐯"], backgroundColor: #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1), cardColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
    ]
    
}

