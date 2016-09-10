//
//  WYEmoticonToolBar.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/10.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYEmoticonToolBar: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

    func setupUI() {
        self.addSubview(stackView)
        stackView.snp_makeConstraints { (make ) in
            make.edges.equalTo(self)
        }
        addChildBtns(imageName: "compose_emotion_table_left", title: "最近")
        addChildBtns(imageName: "compose_emotion_table_mid", title: "默认")
        addChildBtns(imageName: "compose_emotion_table_mid", title: "Emoji")
        addChildBtns(imageName: "compose_emotion_table_right", title: "浪小花")

    }
    
    //添加按钮的方法
    private func addChildBtns (imageName:String , title:String) {
        //初始化button
        let button = UIButton()
        //设置标题
        button.setTitle(title, for: .normal)
        //设置字体颜色
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.gray, for: .selected)
        
        //设置背景图片
        button.setBackgroundImage(UIImage(named: "\(imageName)_normal"), for: UIControlState.normal)
        button.setBackgroundImage(UIImage(named: "\(imageName)_selected"), for: UIControlState.selected)
        stackView.addArrangedSubview(button)
    }

    
    //MARK: - 懒加载控件
    private lazy var stackView :UIStackView = {
        
        let stackView = UIStackView()
        //设置布局方向
        stackView.distribution = .fillEqually
        return stackView
    }()

    
    
}
