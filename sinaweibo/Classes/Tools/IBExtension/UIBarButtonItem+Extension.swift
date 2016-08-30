//
//  UIBarButtonItem+Extension.swift
//  sinaweibo
//
//  Created by 王云 on 16/8/29.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit
extension UIBarButtonItem {
    
    //便利构造函数
    convenience init(imageName:String? = nil,title:String? = nil ,target: Any?, action: Selector?) {
        self.init()
        
        //创建btn并且设置图片
        let btn = UIButton()
        //添加点击事件
        //如果点了,我才添加事件
        if let sel = action {
            
            btn.addTarget(target, action: sel, for: UIControlEvents.touchUpInside)
        }
        
        //如果image有值,我才设置图片
        if let img = imageName {
            
            btn.setImage(UIImage(named:img), for: UIControlState.normal)
            btn.setImage(UIImage(named:"\(img)_highlighted"), for: UIControlState.highlighted)
    }
        
        //设置一系列属性
        if let t = title {
            //标题
            btn.setTitle(t, for: UIControlState.normal)
            //字体大小
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            //字体颜色
            btn.setTitleColor(UIColor.gray, for: UIControlState.normal)
            btn.setTitleColor(UIColor.orange, for: UIControlState.highlighted)
            
        }
        
        btn.sizeToFit()
        customView = btn

        
    }
    
    
    
    
    
    
    
    
    
}
