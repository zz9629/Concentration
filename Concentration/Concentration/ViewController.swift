//
//  ViewController.swift
//  Concentration
//
//  Created by Zheng Zeng on 2020/8/6.
//

import UIKit
import Foundation

class ViewController: UIViewController, CellsViewDelegate {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards )
    var rows = 4
    var cols = 3
    
    private var numberOfPairsOfCards:  Int {
        get {
            return rows * cols / 2
        }
    }
    private(set) var flipCount = 0 {
        didSet {
            labelView.updateLabel(text: "Flips: \(flipCount)")
        }
    }
    
    //label
    private let labelView = LabelView()
    //button
    private let cellsView = CellsView()

    func reset(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
                
        //添加label以及约束
        self.view.addSubview(labelView)//将标签添加到View中
        flipCount = 0
        showLabel()
        
        //添加cells以及约束
        self.view.addSubview(cellsView)//将button添加到View中
        cellsView.delegate = self
        showCells()
        
        //添加reset按钮
        
    }
    
    private func showLabel() {
        let margins = self.view.layoutMarginsGuide
        
        self.view.addSubview(labelView)//将标签添加到View中
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        labelView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        labelView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        labelView.heightAnchor.constraint(equalTo: labelView.widthAnchor, multiplier: 0.5).isActive = true
        
    }
    
    private func showCells() {
        let margins = self.view.layoutMarginsGuide

        cellsView.translatesAutoresizingMaskIntoConstraints = false
        cellsView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        cellsView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        cellsView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
    }
    
    func touchCard(for cardIndex: Int) {
        flipCount += 1
        let cardNumber = cardIndex //cardButtons.firstIndex(of: sender){
        print("choose card:\(cardNumber)")
        game.chooseCard(at: cardNumber)
        updateViewModel()
    }
    
    private func updateViewModel() {
        for index in game.cards.indices {
            let card = game.cards[index]
            if card.isFaceUp {
                cellsView.updateCard(for :index, as: getEmoji(for: card), backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
            }
            else {
                if card.isMatched {
                    cellsView.updateCard(for :index, as: "", backgroundColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0))
                } else {
                    cellsView.updateCard(for :index, as: "", backgroundColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1))
                }
            }
        }
    }
    
    private var emojiArrays = ["🍓","🐶","⭐️","🍔", "🌶", "🍡","🍰", "🍩"," 🦔", "👻"," 😼", "🎃","💩", "🐵"]
    private var dict = [Card: String]()
    
    private func getEmoji(for card:Card) -> String {
        if dict[card] == nil, emojiArrays.count > 0 {
            dict[card] = emojiArrays.remove(at: emojiArrays.count.arc4random)
        }
        return dict[card] ?? "?"
    }
}
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}
