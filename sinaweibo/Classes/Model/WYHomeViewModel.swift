//
//  WYHomeViewModel.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/3.
//  Copyright © 2016年 王云. All rights reserved.
// 专门用来为首页请求数据的

import UIKit

class WYHomeViewModel: NSObject {

    var statusArray: [WYStatus]? 
    
    //加载数据
    func loadData (completion:@escaping (Bool) -> ()) {
        //url地址
        let urlString = "https://api.weibo.com/2/statuses/friends_timeline.json"
        //请求的参数
        let params = [
            "access_token": HMUserAccountViewModel.sharedModel.accessToken ?? ""
        ]
        
        //自己封装的网络请求工具类发起请求
        HMNetworkTools.sharedTools.request(method: .Get, urlString: urlString, parameters: params) { (response, error) in
            if (response == nil || error != nil) {
                print("请求错误\(error)")
                completion(false)
                return
            }
            
            print(response)
            //对数据进行解析
            //
            guard let dictArray = (response! as! [String: Any])["statuses"] as? [[String: Any]] else {
                return
            }
            //字典转模型
            let modelArray = NSArray.yy_modelArray(with: WYStatus.classForCoder(), json: dictArray) as? [WYStatus]
            //赋值给全局属性
            self.statusArray = modelArray
            //刷新数据源
            //self.tableView.reloadData()
            completion(true)
        }
        
    }
   
}
