//
//  Card.swift
//  Concentration
//
//  Created by Zheng Zeng on 2020/8/9.
//

import Foundation

struct Card: Hashable
{
    var hashValue: Int {return identifier}
        
    static func ==(lhs:Card, rhs:Card) ->Bool{
        return lhs.identifier == rhs.identifier
    }
    var isFaceUp = false
    var isMatched = false
    private var identifier = 0
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier()->Int{
        identifierFactory += 1
        return identifierFactory
    }
    init(){
        identifier = Card.getUniqueIdentifier()
    }
}
