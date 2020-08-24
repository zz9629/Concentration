//
//  File.swift
//  Concentration
//
//  Created by Zheng Zeng on 2020/8/14.
//

import Foundation
import UIKit

class LabelView: UIView {
    var label: UILabel
    
    override init(frame: CGRect) {
        //需要先对子类进行初始化
        label = UILabel.init(frame: .zero)
        //父类UIView的初始化
        super.init(frame: frame)
        //调用实例方法 对数据进行改变
        self.setupViews()
    }
    
    override func layoutSubviews() {
       super.layoutSubviews()
       label.frame = bounds
       // setNeedsLayout()
       // layoutIfNeeded()
       // ? why bounds, not frame
    }

    private func setupViews() {
        //添加一个label
        label.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)   //设置标签字体颜色
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 40)
        //label布局
        self.addSubview(label)//将button添加到View中
        let margins = self.layoutMarginsGuide
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
    }
    
    func updateLabel(text: String) {
        label.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
