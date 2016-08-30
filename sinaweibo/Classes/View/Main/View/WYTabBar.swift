//
//  WYTabBar.swift
//  sinaweibo
//
//  Created by 王云 on 16/8/29.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYTabBar: UITabBar {
    
    //定义一个闭包,当按钮点击的时候告诉控制器按钮被点击了
    var closure: (() -> ())?
    
    
    //参考OC的语法,在init方法里面去进行setupUI
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    //这个方法就是当通过xib加载的时候,会抛出一个异常
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //初始化UI,将btn1添加到tabbar上
    func setupUI(){
        addSubview(btn1)
    }
    

    override func layoutSubviews() {
        //一定要调用父类的方法
        super.layoutSubviews()
        
        //设置btn1的大小和位置
        btn1.center = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5)
        
        //每个条目的宽度
        let itemW = UIScreen.main.bounds.width / 5
        //定义当前按钮的索引
        var index = 0
        
        for subView in self.subviews {
            //判断subview的类型是不是UITabBar
            if subView.isKind(of: NSClassFromString("UITabBarButton")!){
                //print(subView)
                //计算x的值
                let itemX = CGFloat(index) * itemW
                //调整宽度
                subView.frame.size.width = itemW
                //调整x的值
                subView.frame.origin.x = itemX
                //index自增
                index = index + 1
                if index == 2 {
                    index = index + 1
                }
                
                
            }
         
        }
       
    }
    
    //监听按钮的点击
   @objc private  func btn1Click(){
        //print("按钮被点击了")
        //当按钮点击的时候,执行闭包
        //和OC里相似,要先判断闭包是否为空,使用一个?实现相似的判断
        closure?()
        
    }
    
    
    //懒加载button,并设置相应的内容
    lazy var btn1 :UIButton = {
        
        let btn1 = UIButton()
        //给按钮添加一个点击事件
        btn1.addTarget(self, action: #selector(btn1Click), for: UIControlEvents.touchUpInside)
        
        
        //按钮的普通和高亮
        btn1.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add"), for: UIControlState.normal)
        btn1.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add_highlighted"), for: UIControlState.highlighted)
        //按钮的背景图片的普通和高亮状态
        btn1.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button"), for: UIControlState.normal)
        btn1.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button_highlighted"), for: UIControlState.highlighted)
        //自动适应大小
        btn1.sizeToFit()
        return btn1
    }()

    
    
    

}
