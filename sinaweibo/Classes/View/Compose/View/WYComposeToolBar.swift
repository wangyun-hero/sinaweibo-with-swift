//
//  WYComposeToolBar.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/8.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYComposeToolBar: UIView {

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
        addChildBtns(imageName: "compose_toolbar_picture")
        addChildBtns(imageName: "compose_mentionbutton_background")
        addChildBtns(imageName: "compose_trendbutton_background")
        addChildBtns(imageName: "compose_emoticonbutton_background")
        addChildBtns(imageName: "compose_add_background")
    }
    
    func addChildBtns (imageName:String) {
        //初始化button
        let button = UIButton()
        //设置背景图片
        button.setImage(UIImage(named:imageName), for: .normal)
        button.setImage(UIImage(named:"\(imageName)_highlighted"), for: .highlighted)
        stackView.addArrangedSubview(button)
    }
    
    //MARK: - 懒加载控件
    lazy var stackView :UIStackView = {
        
        let stackView = UIStackView()
        //设置布局方向
        stackView.distribution = .fillEqually
        return stackView
    }()


}
