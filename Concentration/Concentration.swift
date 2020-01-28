//
//  Concentration.swift
//  Concentration
//
//  Created by Даниил Палеев on 18.01.2020.
//  Copyright © 2020 Даниил Палеев. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    var score = 0{
        didSet{
            score = max(score, 0)
        }
    }
    
    var flips = 0
    
    var indexOfOneOnlyFacedUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            flips += 1
            if let matchIndex = indexOfOneOnlyFacedUpCard, matchIndex != index{
                if cards[matchIndex].identifier == cards[index].identifier {
                    score += 2
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                else{
                    if cards[index].isSeen {
                        score -= 1
                    }
                    
                    if cards[matchIndex].isSeen {
                        score -= 1
                    }
                    
                    cards[index].isSeen = true
                    
                    cards[matchIndex].isSeen = true
                }
                
                cards[index].isFacedUp = true
                indexOfOneOnlyFacedUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFacedUp = false
                }
                cards[index].isFacedUp = true
                indexOfOneOnlyFacedUpCard = index
            }
        }
    }
    
    init(numberOfPairOfCards: Int){
        for _ in 0..<numberOfPairOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        for index in cards.indices {
            let ind = Int(arc4random_uniform(UInt32(cards.count)))
            let storage = cards[ind]
            cards[ind] = cards[index]
            cards[index] = storage
        }
    }
    // TODO: Shuffle the cards
}
