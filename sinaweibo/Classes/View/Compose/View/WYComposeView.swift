//
//  WYComposeView.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/7.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYComposeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        getScreenSnap()
        self.backgroundColor = UIColor.red
        self.frame = UIScreen.main.bounds
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
    }
    
    
    /// 截屏的功能
    ///
    /// - returns: <#return value description#>
    private func getScreenSnap() -> UIImage? {
        
        // 先获取到window
        let window = UIApplication.shared.keyWindow!
        
        // 开启上下文
        // 如果最后一参数传入0的话，会按照屏幕的真实大小来截取，就是不会截取缩放之后的内容
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, false, 0)
        
        // 将window的内容渲染到上下文中
        window.drawHierarchy(in: window.bounds, afterScreenUpdates: false)
        
        // 取到上下文中的图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
        
//         保存到桌面
//        let data = UIImagePNGRepresentation(image!)! as NSData
//        data.write(toFile: "/Users/gaolingfeng/Desktop/Untitled.png", atomically: true)
        
        // 返回结果
        
        return image
    }


}
