//
//  WYVisitorView.swift
//  sinaweibo
//
//  Created by 王云 on 16/8/30.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYVisitorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
    //初始化UI
    func setupUI() {
        self.backgroundColor = UIColor(white: 237/255, alpha: 1)

        //将控件添加到view上
        addSubview(iconView)
        addSubview(circleView)
        addSubview(maskview)
        addSubview(label)
        addSubview(registBtn)
        addSubview(loginBtn)
        
        //添加约束
//        iconView.snp_makeConstraints { (make) in
//            make.center.equalTo(self)
//        }
        
        // 2. 添加约束
        iconView.translatesAutoresizingMaskIntoConstraints = false
        /**
         - 要约束的对象
         - 要约束的属性 left,right
         - 等于
         - 相对于谁来约束
         - 对方控件的约束属性
         - 乘积
         - 偏移量
         
         */
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))

        
       //约束
        circleView.snp_makeConstraints { (make) in
            make.center.equalTo(iconView)
        }
        
        label.snp_makeConstraints { (make) in
            make.centerX.equalTo(iconView)
            make.top.equalTo(circleView.snp_bottom).offset(16)
            make.width.equalTo(225)
            
        }
        
        registBtn.snp_makeConstraints { (make) in
            make.top.equalTo(label.snp_bottom).offset(16)
            make.left.equalTo(label)
            make.width.equalTo(100)
            make.size.equalTo(CGSize(width: 100, height: 35))
        }
        
        loginBtn.snp_makeConstraints { (make) in
            make.right.equalTo(label)
            make.top.equalTo(label.snp_bottom).offset(16)
            make.size.equalTo(CGSize(width: 100, height: 35))
        }
        
        maskview.snp_makeConstraints { (make ) in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(registBtn)
        }
        
        
        
    }
    
    //懒加载控件
    //房子的图标
    lazy var iconView = UIImageView(image: #imageLiteral(resourceName: "visitordiscover_feed_image_house"))
    
    //转圈的图标
    lazy var circleView = UIImageView(image: #imageLiteral(resourceName: "visitordiscover_feed_image_smallicon"))
    
    //中间的label
    lazy var label :UILabel = {
        
        let label = UILabel(textColour: UIColor.darkGray, fontSize: 14)
        //设置换行
        label.numberOfLines = 0
        //内容
        label.text = "哈哈哈哈哈哈哈哈哈ahahhahahahahahahah哈哈哈哈哈哈"
        //设置左对齐
        label.textAlignment = .center
        return label
    }()

    //注册按钮
    lazy var registBtn:(UIButton) = {
        let registBtn = UIButton(textColour: UIColor.orange, fontSize: 14)
        registBtn.setTitle("注册", for: UIControlState.normal)
        registBtn.setBackgroundImage(#imageLiteral(resourceName: "common_button_white"), for: UIControlState.normal)
        
        
       return registBtn
    }()
    
    //登录按钮
    lazy var loginBtn:(UIButton) = {
        let loginBtn = UIButton(textColour: UIColor.orange, fontSize: 14)
        loginBtn.setTitle("登录", for: UIControlState.normal)
        loginBtn.setBackgroundImage(#imageLiteral(resourceName: "common_button_white"), for: UIControlState.normal)
        
        return loginBtn
    }()

    
    //懒加载半透明图
    lazy var maskview = UIImageView(image: #imageLiteral(resourceName: "visitordiscover_feed_mask_smallicon"))
    
    
    

}
