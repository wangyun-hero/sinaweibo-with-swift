//
//  UIImage+Extension.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/7.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

extension UIImage {
    /// 截屏的功能
    ///
    /// - returns: <#return value description#>
   class func getScreenSnap() -> UIImage? {
        
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
    
    func scaleTo(width:CGFloat) -> UIImage {
        if self.size.width < width {
            return self
        }
        //根据宽度求出等比例缩放之后的高度
        let height = self.size.height * (width / self.size.width)
        //定义一个范围
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        //开启上下文
        UIGraphicsBeginImageContext(rect.size)
        // 会将当前图片的所有内容完整的画到上下文中
        self.draw(in: rect)
        //取值
        let result = UIGraphicsGetImageFromCurrentImageContext()!
        //关闭上下文
        UIGraphicsEndImageContext()
        //返回
        return result
    }

}
