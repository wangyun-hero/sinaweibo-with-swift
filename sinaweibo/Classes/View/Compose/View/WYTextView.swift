//
//  WYTextView.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/8.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYTextView: UITextView {

    var placeholder : String? {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    //重写font属性,当外界设置font的时候能保证placeholderlabel的大小一样
    override var font : UIFont? {
        didSet{
            placeholderLabel.font = font
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
        
        //注册通知,来监听textview文字的输入,我们需要隐藏placeholder
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
    }
    
    func textDidChange() {
        //当textView里面有文字的时候就隐藏placeholder
        placeholderLabel.isHidden = hasText
    }
    
    //移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.snp_makeConstraints { (make ) in
            make.width.lessThanOrEqualTo(self.frame.width - 2 * 5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI () {
        //添加控件
        addSubview(placeholderLabel)
        //约束
        placeholderLabel.snp_makeConstraints { (make ) in
            make.top.equalTo(self).offset(8)
            make.left.equalTo(self).offset(5)
        }
    }
    
    //懒加载控件
    lazy var placeholderLabel :UILabel = {
        
        let placeholderLabel = UILabel(textColour: UIColor.lightGray, fontSize: 12)
        placeholderLabel.numberOfLines = 0
        return placeholderLabel
    }()

    
    
    
    
}
