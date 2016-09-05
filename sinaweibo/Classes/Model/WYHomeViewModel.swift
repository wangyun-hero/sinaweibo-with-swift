//
//  WYHomeViewModel.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/3.
//  Copyright © 2016年 王云. All rights reserved.
// 专门用来为首页请求数据的

import UIKit
import SDWebImage
class WYHomeViewModel: NSObject {

    var statusArray: [WYStatusViewModel]?
    
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
            
            //print(response)
            //对数据进行解析
            //
            guard let dictArray = (response! as! [String: Any])["statuses"] as? [[String: Any]] else {
                return
            }
            //字典转模型
            let modelArray = NSArray.yy_modelArray(with: WYStatus.classForCoder(), json: dictArray) as? [WYStatus]
            
            //定义一个WYStatusViewModel数组
            var tempArray = [WYStatusViewModel]()
            //循环将status存入单个WYStatusViewModel,然后就有一个WYStatusViewModel数组
            for status in modelArray! {
                let viewModel = WYStatusViewModel()
                viewModel.status = status
                tempArray.append(viewModel)
            }
            
            //赋值给全局属性
            self.statusArray = tempArray
            
            //在闭包回调之前下载好配图视图上的单张图片
            //告诉控制器,数据已经准备好了
            self.cachesingleImage(status: tempArray,completion: completion)
            
        }
        
    }
   
    //异步下载图片的方法
   private func cachesingleImage(status:[WYStatusViewModel],completion:@escaping (Bool) -> ()) {
        //初始化一个调度组
        let group = DispatchGroup.init()
        //遍历去判断是否有单张图片
        for value in status {
            
            //判断原创微博或者转发微博的配图是否为1
            guard let pic_urls = value.status?.pic_urls?.count == 1 ? value.status?.pic_urls : value.status?.retweeted_status?.pic_urls,pic_urls.count == 1 else {
                //继续下一次循环
                continue
            }
            
            //取到该单张图片的模型
            let photoInfo = pic_urls.first
            //取到图片地址
            let urlString = photoInfo?.thumbnail_pic
            //将地址的字符串初始化成url
            let url = URL(string: urlString ?? "")
            
            //进入调度组
            group.enter()
            //下载图片
            SDWebImageManager.shared().downloadImage(with: url, options: [], progress: nil, completed: { (image, error, _, _, _) in
                //使用模型去记录图片的大小
                photoInfo?.size = image?.size
                print("下载完成\(urlString)")
                //出组
                group.leave()
            })
        }
        
        //调度组自带的监听方法
        group.notify(queue: DispatchQueue.main) {
            print("所以图片下载完成")
            completion(true)
        }
        
    }
    
    
    
    
    
}
