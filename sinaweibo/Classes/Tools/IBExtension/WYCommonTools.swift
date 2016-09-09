//
//  WYCommonTools.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/2.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

let HMChangeRootVCNotification = "HMChangeRootVCNotification"
// 抽取屏幕宽高
let HMScreenW = UIScreen.main.bounds.width
let HMScreenH = UIScreen.main.bounds.height

// 随机颜色
var RandomColor: UIColor {
get {
    return UIColor(red: CGFloat(arc4random() % 256) / 255, green: CGFloat(arc4random() % 256) / 255, blue: CGFloat(arc4random() % 256) / 255, alpha: 1)
}
}
