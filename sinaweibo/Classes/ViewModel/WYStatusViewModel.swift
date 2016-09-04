//
//  WYStatusViewModel.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/3.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYStatusViewModel: NSObject
{

    // 当前微博作者的会员图标
    var memberImage: UIImage?
    // 认证的图标
    var avatarImage: UIImage?
    // 转发数
    var reposts_count: String?
    // 评论数量的字符串
    var comments_count: String?
    // 静态数量的字符串
    var attitudes_count: String?
    // 转发微博的内容
    var retweetStautsText: String?
    
    
    var status: WYStatus?
        {
        didSet
        {
            // 会员图标计算出来
            if let mbrank = status?.user?.mbrank, mbrank > 0
            {
                // 会员图标名字
                let imageName = "common_icon_membership_level\(mbrank)"
                memberImage = UIImage(named: imageName)
            }
            
//            // 认证图标计算 认证类型 -1：没有认证，1：认证用户，2,3,5: 企业认证，220: 达人
            if let type = status?.user?.verified_type
            {
                switch type
                {
                case 1: // 大v
                    avatarImage = #imageLiteral(resourceName: "avatar_vip")
                case 2, 3, 5: // 企业
                    avatarImage = #imageLiteral(resourceName: "avatar_enterprise_vip")
                case 220: // 达人
                    avatarImage = #imageLiteral(resourceName: "avatar_grassroot")
                default:
                    break
                }
            }
            
            // 计算转发，评论，赞数
            reposts_count = caclCount(count: status?.reposts_count ?? 0, defaultTitle: "转发")
            comments_count = caclCount(count: status?.comments_count ?? 0, defaultTitle: "评论")
            attitudes_count = caclCount(count: status?.attitudes_count ?? 0, defaultTitle: "赞")

            // 计算转发微博的内容
            if let text = status?.retweeted_status?.text, let name = status?.retweeted_status?.user?.name{
                retweetStautsText = "@\(name):\(text)"
            }

            
        }
    }
    
    /// 计算转发评论赞的文字显示内容
    ///
    /// - parameter count:        数量
    /// - parameter defaultTitle: 如果数量为0，就返回默认的标题
    ///
    /// - returns: <#return value description#>
    private func caclCount(count: Int, defaultTitle: String) -> String
    {
        if count == 0 {
            return defaultTitle
        }else{
            // 0 - 10000 --> 显示具体的数值
            // 10000-11000 --> 1万
            // 13000 --> 1.3万
            
            // 20800 2万
            if count < 10000 {
                return "\(count)"
            }else{
                // 取到十位数
                let result = count / 1000
                // 取到小数点后的一位
                let str = "\(Float(result) / 10)"
                let string = "\(str)万"
                // 如果有.0就替换成空字符串
                return string.replacingOccurrences(of: ".0", with: "")
            }
        }
    }
    
}
