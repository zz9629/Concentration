//
//  ViewController.swift
//  Concentration
//
//  Created by Zheng Zeng on 2020/8/6.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards:numberOfPairsOfCards )
    
    var numberOfPairsOfCards :Int{
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0
    {
        didSet{
            Label.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet private weak var Label: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewModel()
        }
        else{
            print("There is no card!")
        }
    }
    private func updateViewModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private var emojiArrays = ["🍓","🐶","⭐️","🍔", "🌶", "🍡","🍰", "🍩"," 🦔", "👻"," 😼", "🎃","💩", "🐵"]
    private var dict = [Card: String]()
    
    private func emoji(for card:Card) -> String {
        if dict[card] == nil, emojiArrays.count > 0 {
            dict[card] = emojiArrays.remove(at: emojiArrays.count.arc4random)
        }
        return dict[card] ?? "?"
    }
}
extension Int {
    var arc4random: Int{
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0{
            return -Int(arc4random_uniform(UInt32(self)))
        }
        else {
            return 0
        }
    }
}
