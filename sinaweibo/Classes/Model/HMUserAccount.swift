//
//  HMUserAccount.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/2.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class HMUserAccount: NSObject ,NSCoding{

    //返回值字段,相当于key
    /// 访问令牌
    var access_token: String?
    /// 生命周期，多少秒之后就accessToken就不能使用了
//    var expires_in: TimeInterval = 0
    var expires_in: TimeInterval = 0 {
        didSet{
            // 过期时间 ＝ 当前时间 + expires_in
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    /// 当前用户的id
    var uid: String?
    
    
    //因为有声明周期并不能让我们知道具体声明时间过期,所以定义这个属性,可以直观的看到声明时候过期
    /// 过期日期
    var expiresDate: Date?

    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
    //解档
    required init?(coder decoder: NSCoder) {
        access_token = decoder.decodeObject(forKey: "access_token") as? String
        uid = decoder.decodeObject(forKey: "uid") as? String
        expiresDate = decoder.decodeObject(forKey: "expiresDate") as? Date
    }
    
    
    
    
    
    // 归档
    func encode(with encoder: NSCoder) {
        encoder.encode(access_token, forKey: "access_token")
        encoder.encode(uid, forKey: "uid")
        encoder.encode(expiresDate, forKey: "expiresDate")
        
        
    }

    
    
}
