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
    // api 定义清晰，done
}

class CellsView: UIStackView {
    
    /**
    定义委托，使用weak，避免循环强引用
    */
    weak var delegate: CellsViewDelegate?

    //  - 除了delegate还有什么方式，优劣？
    // 定义在view ，实现在vc
    //    var onclick((Int)->Void) ?

    //????
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.setupViews()
//    }

    init(frame: CGRect, size: (Int, Int)) {
        super.init(frame: frame)
        self.setupViews(size: size)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //  - collection view ??
    // 职责反转，done

    /*
     生成 rows * cols 的卡牌
     para: (Int, Int)
     */
    private func setupViews(size : (rows: Int, cols: Int))  {
        self.axis = .vertical
        self.alignment = .center
        self.distribution = .fillEqually
        self.spacing = 8

        let rows = size.rows
        let cols = size.cols

        var countOfButton = 0

        for _ in 0..<rows {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .center
            stack.distribution = .fillEqually
            stack.spacing = 8
            
            for _ in 0..<cols {
                // button
                let button = UIButton.init(frame: .zero)
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 50)
                button.layer.cornerRadius = 8
                // use button.tag
                button.tag = 1000 + countOfButton
                countOfButton += 1
                button.addTarget(self, action: #selector(onClick(sender: )), for: .touchUpInside)

                stack.addArrangedSubview(button)
                button.snp.makeConstraints { (make) -> Void in
                    make.top.bottom.equalToSuperview()
                }
            }
            
            self.addArrangedSubview(stack)
            stack.snp.makeConstraints { (make) -> Void in
                make.left.right.equalToSuperview()
            }
        }
    }

    /**
        对于指定卡牌进行颜色和内容的更新
     */
    func updateCard(for index : Int, as emoji: String, backgroundColor : UIColor) {
        let tag = index + 1000
        let button = self.viewWithTag(tag) as! UIButton?
        button?.setTitle(emoji, for: UIControl.State.normal)
        button?.backgroundColor = backgroundColor
    }

    /**
     点击卡牌之后调用对VC的委托
     */
    @objc
    func onClick(sender: UIButton ) {
        self.delegate?.touchCard(for :sender.tag - 1000)
    }
}
