//
//  WYStatusViewModel.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/3.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYStatusViewModel: NSObject {

    // 当前微博作者的会员图标
    var memberImage: UIImage?
    // 认证的图标
    var avatarImage: UIImage?
    
    var status: WYStatus? {
        didSet {
            // 会员图标计算出来
            if let mbrank = status?.user?.mbrank, mbrank > 0 {
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
        }
    }
    
}
