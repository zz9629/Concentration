//
//  CellsView.swift
//  concentration1
//
//  Created by Zheng Zeng on 2020/8/14.
//  Copyright © 2020 Zheng Zeng. All rights reserved.
//

import Foundation
import UIKit

// anyobject 是什么 why 引用类型
protocol CellsViewDelegate: AnyObject {
    func touchCard(for cardIndex: Int)
    // api 定义清晰
}

class CellsView: UIStackView {
    var cardButtons: [UIButton]
    // why weak??
    weak var delegate: CellsViewDelegate?
    
    override init(frame: CGRect) {
        cardButtons = []
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupViews()  {
        self.axis = .vertical//.horizontal
        self.alignment = .center
        self.distribution = .fillEqually
        self.spacing = 4
        
        let rows = 4, cols = 3  //职责反转，已修改
        for _ in 0..<rows {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .center
            stack.distribution = .fillEqually
            stack.spacing = 8
            
            for _ in 0..<cols {
                let button = UIButton.init(frame: .zero)
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 50)
                button.layer.cornerRadius = 8
                // use button.tag
                cardButtons.append(button)
                button.addTarget(self, action: #selector(onClick(sender: )), for: .touchUpInside)
                stack.addArrangedSubview(button)
            }
            
            self.addArrangedSubview(stack)
            let margins = self.layoutMarginsGuide

            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
            stack.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        }
    }
    
    func updateCard(for index : Int, as emoji: String, backgroundColor : UIColor) {
        cardButtons[index].setTitle(emoji, for: UIControl.State.normal)
        cardButtons[index].backgroundColor = backgroundColor
    }
    
    @objc
    func onClick(sender: UIButton ) {
        if let index = cardButtons.firstIndex(of: sender) {
            self.delegate?.touchCard(for :index)
        }
    }
}
