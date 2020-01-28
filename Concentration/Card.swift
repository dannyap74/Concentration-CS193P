//
//  Card.swift
//  Concentration
//
//  Created by Даниил Палеев on 22.01.2020.
//  Copyright © 2020 Даниил Палеев. All rights reserved.
//

import Foundation

struct Card
{
    var isSeen = false
    var isFacedUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
