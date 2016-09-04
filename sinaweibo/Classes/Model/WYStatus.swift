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
    /// 当前微博的作者信息
    var user: WYUser?
    /// 转发数
    var reposts_count: Int = 0
    /// 评论数
    var comments_count: Int = 0
    /// 表态数
    var attitudes_count: Int = 0
    
    /// 转发微博
    var retweeted_status: WYStatus?
    
    /// 配图的数据，是一个数组，需要告诉第三方框架里面装的是什么类型的数据  ,数组里面装的是字典,一个字典对应一个模型,所以这里其实是一个模型数组
    var pic_urls: [WYStatusPictureInfo]?
    
    /// 告诉YYModel,pic_urls这个数组里面元素的类型是什么
    /// 告诉 yymodel ，pic_urls这个数组里面的元素类型是什么
    class func modelContainerPropertyGenericClass() -> ([String: Any]) {
        return [
            "pic_urls": WYStatusPictureInfo.self
        ]
    }
 
}
