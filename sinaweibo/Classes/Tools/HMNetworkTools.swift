//
//  HMNetworkTools.swift
//  Swift网络工具类封装
//
//  Created by heima on 16/8/30.
//  Copyright © 2016年 heima. All rights reserved.
//

import UIKit
import AFNetworking


/// 请求方式的枚举
///
/// - Get:  <#Get description#>
/// - Post: <#Post description#>
enum HMHttpMethod: String {
    case Get = "GET"
    case Post = "POST"
}

class HMNetworkTools: AFHTTPSessionManager {
    
    static let sharedTools: HMNetworkTools = {
        let tools = HMNetworkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
    }()
    
    // 将回调数据的闭包定义成一个别名
    typealias HMRequestCallBack = @escaping (Any?, Error?) -> ()
    
    // 定义一个请求网络的方法
    func request(method: HMHttpMethod, urlString: String, parameters: Any?, completion: HMRequestCallBack) {
        
        // 定义一个成功的闭包
        let successClosure: (URLSessionDataTask, Any?) -> () = { (_, responseObject) in
            // 请求成功的回调
            completion(responseObject, nil)
        }
        
        let failureClosure: (URLSessionDataTask?, Error) -> () = { (_, error) in
            // 请求失败的回调
            completion(nil, error)
        }
        
        // 根据不同的请求方式去发送不同的请求
        if method == .Get {
            self.get(urlString, parameters: parameters, progress: nil, success: successClosure, failure: failureClosure)
        }else{
            self.post(urlString, parameters: parameters, progress: nil, success: successClosure, failure:failureClosure)
        }
    }
}
