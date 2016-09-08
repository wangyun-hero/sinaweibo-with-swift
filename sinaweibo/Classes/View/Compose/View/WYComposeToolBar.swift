//
//  WYComposeToolBar.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/8.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

/// 用于判断按钮类型的枚举
///
/// - picture: 图片
/// - mention: @
/// - trend:   #
/// - emotion: 表情
/// - add:     +
enum ComposeToolBarButtonType: Int {
    //    case picture = 0
    //    case mention = 1
    //    case trend = 2
    //    case emotion = 3
    //    case add = 4
    case picture = 0, mention, trend, emotion, add
}

//定义一个协议
protocol WYComposeToolBarDelegata: NSObjectProtocol {
    //定义协议方法
    func composeToolBar(toolBar:WYComposeToolBar,type:ComposeToolBarButtonType)
}

class WYComposeToolBar: UIView {
    
    //定义代理属性
    weak var delegata:WYComposeToolBarDelegata?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        //设置背景,,可以用一张图片
        self.backgroundColor = UIColor(patternImage: UIImage(named: "compose_toolbar_background")!)
        //添加stackview
        addSubview(stackView)
        //约束
        stackView.snp_makeConstraints { (make ) in
            make.edges.equalTo(self)
        }
        
        //添加底部的5个btn
        addChildBtns(imageName: "compose_toolbar_picture", type:.picture)
        addChildBtns(imageName: "compose_mentionbutton_background", type:.mention)
        addChildBtns(imageName: "compose_trendbutton_background" ,type:.trend)
        addChildBtns(imageName: "compose_emoticonbutton_background", type:.emotion)
        addChildBtns(imageName: "compose_add_background", type:.add)
    }
    
    func addChildBtns (imageName:String , type:ComposeToolBarButtonType) {
        //初始化button
        let button = UIButton()
        //用tag记录
        button.tag = type.rawValue
        //监听按钮的点击
        button.addTarget(self, action: #selector(childButtonClick(btn:)), for: .touchUpInside)
        
        //设置背景图片
        button.setImage(UIImage(named:imageName), for: .normal)
        button.setImage(UIImage(named:"\(imageName)_highlighted"), for: .highlighted)
        stackView.addArrangedSubview(button)
    }
    
    //按钮点击事件的监听
    func childButtonClick(btn:UIButton) {
        //在这里告诉控制器自己被点击
        //在这里执行代理
        let type = ComposeToolBarButtonType(rawValue:btn.tag)
        
        delegata?.composeToolBar(toolBar: self, type: type!)
        
        
        
    }
    
    //MARK: - 懒加载控件
    lazy var stackView :UIStackView = {
        
        let stackView = UIStackView()
        //设置布局方向
        stackView.distribution = .fillEqually
        return stackView
    }()


}
