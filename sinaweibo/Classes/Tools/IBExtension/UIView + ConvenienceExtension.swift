//
//  UIView + ConvenienceExtension.swift
//  sinaweibo
//
//  Created by 王云 on 16/8/30.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit
extension UILabel{
    
    convenience init(textColour:UIColor,fontSize:CGFloat) {
        self.init()
        self.textColor = textColour
        self.font = UIFont.systemFont(ofSize: fontSize)
        
    }
   
}


extension UIButton {
    
    convenience init(textColour:UIColor,fontSize:CGFloat) {
        self.init()
        self.setTitleColor(textColour, for: UIControlState.normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        
        
    }
    
    
    
}









