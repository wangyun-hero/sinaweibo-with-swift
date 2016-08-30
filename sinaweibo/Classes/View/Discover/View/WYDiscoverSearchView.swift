//
//  WYDiscoverSearchView.swift
//  sinaweibo
//
//  Created by 王云 on 16/8/29.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

//其实就是一个button,看着像创建view
@IBDesignable class WYDiscoverSearchView: UIButton {

//    @IBInspectable  var cornerRadius : CGFloat  {
//        set {
//            layer.cornerRadius = newValue
//        }
//        get {
//            return layer.cornerRadius
//        }
//        
//    }
    
    //类方法创建一个btn,并返回btn
  class func searchView () -> WYDiscoverSearchView{
        
        let btn = Bundle.main.loadNibNamed("WYDiscoverSearchView", owner: nil, options: nil)?.last as! WYDiscoverSearchView
        
        return btn
        
    }
    
    override func awakeFromNib() {
        //将搜索的图片和右边的文字拉开距离
        imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10)
        titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, -20)
        
        //倒角
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    
    
    

}
