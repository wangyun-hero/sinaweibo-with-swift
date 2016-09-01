//
//  HMUserAccountViewModel.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/2.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class HMUserAccountViewModel: NSObject {

    // 当前 viewModel 对应的模型
    var account: HMUserAccount?
    
    //单例
    static let sharedModel: HMUserAccountViewModel = HMUserAccountViewModel()
    
    
    
    //获取token的方法
    func loadAccessToken (code:String) {
        //请求地址
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        /*
         client_id	true	string	申请应用时分配的AppKey。
         client_secret	true	string	申请应用时分配的AppSecret。
         grant_type	true	string	请求的类型，填写authorization_code
         
         grant_type为authorization_code时
         必选	类型及范围	说明
         code	true	string	调用authorize获得的code值。
         redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
         */
        
        
        //请求的参数
        let params = [
            "client_id": WB_APPKEY,
            "client_secret": WB_SECRET,
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": WB_REDIRECT_URI
        ]
        
        //使用afn发起请求
        HMNetworkTools.sharedTools.request(method: .Post, urlString: urlString, parameters: params) { (response, error) in
            
            if response == nil || error != nil {
                print("请求错误\(error)")
                return
            }
            //将字典转模型
            let account = HMUserAccount(dict: response! as! [String:Any])
            
            // 代码走到这一步，就代表accessToken获取完成
            // 接下来要去获取用户的个人信息,比如说头像，头像要欢迎页面要使用
            self.loadUserInfo(account: account)
            
            
        }
        
    }
    
    //获取用户的信息
    func loadUserInfo (account : HMUserAccount) {
        //定义请求地址,根据微博的API来
        let URLString = "https://api.weibo.com/2/users/show.json"
        //定义请求参数
        let params = [
            "access_token": (account.access_token ?? ""),
            "uid": (account.uid ?? "")
        ]
        
        //发送请求
        HMNetworkTools.sharedTools.request(method: .Get, urlString: URLString, parameters: params) { (response, error) in
            if response == nil || error != nil {
                print("请求错误\(error )")
                return
            }
            //保存头像和昵称
            let dict = response! as! [String:Any]
            // 从字典中取出对应的值，设置到模型中
            account.name = dict["name"] as? String
            account.profile_image_url = dict["profile_image_url"] as? String
            
            //归档
            self.saveAccount(account: account)
            
            
            //!!!!!!!!!!!!!!!!!!!!!!!
            
            // 登录成功，要通知外界
            // 执行代理方法
            // 发送通知
            // 执行闭包，传入true，代表登录成功
            completion(true)
        }
        
        
    }
    
    //从上面抽出来的方法,保存用户的信息
    func saveAccount (account : HMUserAccount) {
        
        let file = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("userAccount.archive")
        // 2. 归档
        NSKeyedArchiver.archiveRootObject(account, toFile: file)
        
        
    }

    
    
    
}
