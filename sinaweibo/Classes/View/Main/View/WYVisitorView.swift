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
 
    
    func setvisitorViewInfo (imageName:String?,message:String?) {
        //此时是后三个页面的情况
        if imageName != nil {
            circleView.isHidden = true
            iconView.image = UIImage(named: imageName!)
            label.text = message
            
        }
        else
        {
            //代表是首页
            label.text = message
            startAnimation()
        }
        
        
    }
    
    
    //让图片转起来
    func startAnimation () {
        //初始化一个动画
        let ani = CABasicAnimation(keyPath: "transform.rotation")
        //设置到某一个值
        ani.toValue = M_PI * 2
        //设置重复次数
        ani.repeatCount = MAXFLOAT
        //设置动画的时间
        ani.duration = 20
        // 是否移除在完成的时候。如果切换界面或者应用程序退到后台，那么动画会被释放掉。指定这个值的话就代表在做以上两个操作的时候不让其移除
        ani.isRemovedOnCompletion =  false
        //添加动画
        circleView.layer.add(ani, forKey: nil)
        
    }
    
    
    //初始化UI
   private func setupUI() {
        backgroundColor = UIColor(white: 237/255, alpha: 1)

        //将控件添加到view上
        addSubview(circleView)
        addSubview(maskview)
        addSubview(iconView)
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
        circleView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(iconView)
        }
        
        label.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView)
            make.top.equalTo(circleView.snp_bottom).offset(16)
            make.width.equalTo(225)
            
        }
        
        registBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(label.snp_bottom).offset(16)
            make.left.equalTo(label)
            //make.width.equalTo(100)
            make.size.equalTo(CGSize(width: 80, height: 30))
        }
        
        loginBtn.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(label)
            make.top.equalTo(label.snp_bottom).offset(16)
            make.size.equalTo(CGSize(width: 80, height: 30))
        }
        
        maskview.snp_makeConstraints { (make ) -> Void in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(registBtn)
        }
        
        
        
    }
    
    //懒加载控件
    //房子的图标
    private lazy var iconView = UIImageView(image: #imageLiteral(resourceName: "visitordiscover_feed_image_house"))
    
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
