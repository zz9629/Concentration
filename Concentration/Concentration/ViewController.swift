//
//  ViewController.swift
//  Concentration
//
//  Created by Zheng Zeng on 2020/8/6.
//



import UIKit
import Foundation
import SnapKit

class ViewController: UIViewController, CellsViewDelegate {
    // 游戏的数据。因为会用到实例化之后的数据，所以用lazy
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards )

    // 生成卡牌的规格，由VC定义
    private var size : (rows: Int, cols: Int) = (4, 3)

    // 卡牌的对数，Concentration实例化时使用
    private var numberOfPairsOfCards:  Int {
        get {
            return size.rows * size.cols / 2
        }
    }

    // 鼠标点击的次数，更新在label中
    private(set) var flipCount = 0 {
        didSet {
            labelView.updateLabel(text: "Flips: \(flipCount)")
        }
    }
    
    //label 视图：显示点击次数flipCount
    private let labelView = LabelView()
    //cells 视图：显示卡牌主体
    private lazy var cellsView = CellsView(frame: .zero, size: self.size)

    //TODO：开始新游戏
    func reset(rows: Int, cols: Int) {
        self.size.rows = rows
        self.size.cols = cols
    }

    lazy var box = UIView()


    override func viewDidLoad() {
        super.viewDidLoad()

        //添加label以及约束
        self.view.addSubview(labelView)//将标签添加到View中
        flipCount = 0
        labelView.snp.makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(150) 
        }

        //添加cells以及约束
        self.view.addSubview(cellsView)//将button添加到View中
        cellsView.delegate = self
        cellsView.snp.makeConstraints { (make) -> Void in
            make.topMargin.leftMargin.rightMargin.equalToSuperview()
            make.bottom.equalTo(labelView.snp.topMargin)
        }
        //添加reset按钮

    }

    // 委托函数，接受被点击的卡牌index，对game的数据进行更新
    func touchCard(for cardIndex: Int) {
        flipCount += 1                      // 点击次数++
        print("choose card:\(cardIndex)")
        game.chooseCard(at: cardIndex)      // 游戏的interface，选中一张卡牌
        updateViewModel()                   // 更新视图
    }

    // 访问游戏中的所有卡牌，查看他们的状态。更新视图
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
    
    private var emojiArrays = "🍓🐶⭐️🍔🌶🍡🍰🍩🦔👻😼🎃💩🐵"
    private var dict = [Card: String]()
    
    private func getEmoji(for card:Card) -> String {
        if dict[card] == nil, emojiArrays.count > 0 {
            let stringIndex = emojiArrays.index(emojiArrays.startIndex,
                                                offsetBy: emojiArrays.count.arc4random)
            dict[card] = String(emojiArrays.remove(at: stringIndex))
        }
        return dict[card] ?? "?"
    }
}
// 生成随机数
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
