//
//  Concentration.swift
//  Concentration
//
//  Created by Zheng Zeng on 2020/8/9.
//

import Foundation

struct Concentration{
    private(set) var cards = [Card]()
    private var onlyOneCardFaceUp : Int? {
        get{
            let faceUpCards = cards.indices.filter {
                return cards[$0].isFaceUp
            }
            return faceUpCards.oneAndOnly
//            return faceUpCards.count == 1 ? faceUpCards.first: nil
//            var foundIndex: Int?
//            for index in cards.indices{
//                if cards[index].isFaceUp {
//                    if foundIndex == nil{
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index:Int){
        assert(cards.indices.contains(index),"Concentration.chooseCard():index out of range")
        if !cards[index].isMatched{
            if let matchIndex = onlyOneCardFaceUp, index != matchIndex{
                //check if two cards are match?
                if(cards[matchIndex] == cards[index]){
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }else {
                onlyOneCardFaceUp = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concenration.init():you must have at least one pair of cards")
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        //TODO: shuffle
        cards.shuffle()
    }
}

extension Collection{
    var oneAndOnly : Element?{
        return count == 1 ? first:nil
    }
}
