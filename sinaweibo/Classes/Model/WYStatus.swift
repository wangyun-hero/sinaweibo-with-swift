//
//  WYStatus.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/3.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYStatus: NSObject {

    /// 微博的创建时间
    var created_at: String?
    /// 微博的Id
    var id: Int64 = 0
    /// 微博内容
    var text: String?
    /// 微博的来源
    var source: String?
   
}
