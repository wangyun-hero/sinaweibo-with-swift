//
//  WYUser.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/3.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYUser: NSObject {

    // 用户的昵称
    var name: String?
    // 用户的头像
    var profile_image_url: String?
    /// 认证类型 -1：没有认证，1：认证用户，2,3,5: 企业认证，220: 达人
    var verified_type: Int = 0
    // 会员等级
    var mbrank: Int = 0
  
}
