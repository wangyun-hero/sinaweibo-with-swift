//
//  WYEmotionKeyboard.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/10.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYEmotionKeyboard: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func setupUI() {
        backgroundColor = UIColor(patternImage: UIImage(named:"emoticon_keyboard_background")!)
        //添加底部控件
        addSubview(toolBar)
        //约束
        toolBar.snp_makeConstraints { (make ) in
            make.bottom.left.right.equalTo(self)
            make.height.equalTo(37)
        }
    }
    
    //懒加载控件
    lazy var toolBar: WYEmoticonToolBar = WYEmoticonToolBar()

}
