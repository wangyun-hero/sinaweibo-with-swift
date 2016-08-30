//
//  UIView+IBExtension.swift
//  sinaweibo
//
//  Created by 王云 on 16/8/29.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit
extension UIView {
    
    
    @IBInspectable  var cornerRadius : CGFloat  {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
        
    }
    
    
    
    
    
    
    
}
