//
//  WYOAuthViewController.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/1.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit
import SVProgressHUD

 let WB_APPKEY = "2367628679"
 let WB_SECRET = "7c6e35f40cf8dde1131ac63e35e94305"
 let WB_REDIRECT_URI = "http://www.itheima.com/"

class WYOAuthViewController: UIViewController , UIWebViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "新浪微博-登录"
        //左边的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", target: self, action: #selector(close))
        //右边的item
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", target: self, action: #selector(autoFill))
        
        //添加webview
        view.addSubview(webView)
        
        //设置约束
        webView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
//        App Key：2367628679
//        App Secret：7c6e35f40cf8dde1131ac63e35e94305
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WB_APPKEY)&redirect_uri=\(WB_REDIRECT_URI)"
        
        //初始化一个url
        let url = URL(string: urlString)
        //通过url初始化一个请求
        let urlRequest = URLRequest(url: url!)
        //通过webview加载url
        webView.loadRequest(urlRequest)
        
        
        
    }
    
   @objc private func close () {
        self.dismiss(animated: true, completion: nil)
    
        
    }
    
    //自动填充的方法实现
    func autoFill() {
        // 去执行js代码
        let jsString = "document.getElementById('userId').value = '18961290300';document.getElementById('passwd').value = 'yun120411';"
        webView.stringByEvaluatingJavaScript(from: jsString)
    
    }

//    //获取token的方法
//    func loadAccessToken (code:String) {
//        //请求地址
//        let urlString = "https://api.weibo.com/oauth2/access_token"
//        
//        /*
//         client_id	true	string	申请应用时分配的AppKey。
//         client_secret	true	string	申请应用时分配的AppSecret。
//         grant_type	true	string	请求的类型，填写authorization_code
//         
//         grant_type为authorization_code时
//         必选	类型及范围	说明
//         code	true	string	调用authorize获得的code值。
//         redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
//         */
//
//        
//        //请求的参数
//        let params = [
//            "client_id": WB_APPKEY,
//            "client_secret": WB_SECRET,
//            "grant_type": "authorization_code",
//            "code": code,
//            "redirect_uri": WB_REDIRECT_URI
//        ]
//
//        //使用afn发起请求
//        HMNetworkTools.sharedTools.request(method: .Post, urlString: urlString, parameters: params) { (response, error) in
//            
//            if response == nil || error != nil {
//                print("请求错误\(error)")
//                return
//            }
//            //将字典转模型
//            let account = HMUserAccount(dict: response! as! [String:Any])
//            
//            // 代码走到这一步，就代表accessToken获取完成
//            // 接下来要去获取用户的个人信息,比如说头像，头像要欢迎页面要使用
//            self.loadUserInfo(account: account)
//
// 
//        }
//      
//    }
//    
//    //获取用户的信息
//    func loadUserInfo (account : HMUserAccount) {
//        //定义请求地址,根据微博的API来
//        let URLString = "https://api.weibo.com/2/users/show.json"
//        //定义请求参数
//        let params = [
//            "access_token": (account.access_token ?? ""),
//            "uid": (account.uid ?? "")
//        ]
//        
//        //发送请求
//        HMNetworkTools.sharedTools.request(method: .Get, urlString: URLString, parameters: params) { (response, error) in
//            if response == nil || error != nil {
//                print("请求错误\(error )")
//                return
//            }
//            //保存头像和昵称
//            let dict = response! as! [String:Any]
//            // 从字典中取出对应的值，设置到模型中
//            account.name = dict["name"] as? String
//            account.profile_image_url = dict["profile_image_url"] as? String
//            
//            //归档
//            self.saveAccount(account: account)
//        }
//
//        
//    }
//    
//    //从上面抽出来的方法,保存用户的信息
//    func saveAccount (account : HMUserAccount) {
//        
//        let file = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("userAccount.archive")
//        // 2. 归档
//        NSKeyedArchiver.archiveRootObject(account, toFile: file)
//
//        
//    }
    
    
    
    
    
    //request里面的url就是我们拼接的url
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        //如果url有值,那么我们去到地址字符串并且判断
        if let u = request.url {
            //去到url地址的字符串
            let urlString = u.absoluteString
            // 如果不是以回调页开头,那么我们就加载
            if !urlString.hasPrefix(WB_REDIRECT_URI) {
                return true
            }
        }
        //代码走到这里代表是回调页开头
        if let query = request.url?.query {
            //取到code
            //print(query)
            let code = query.substring(from: "code=".endIndex)
            print(code)
            
            //将我们获取的code传入获取AccessToken的方法,获取AccessToken
            HMUserAccountViewModel.sharedModel.loadAccessToken(code: code, completion: {(isSuccess) -> () in
                
                if isSuccess {
                    // 登录成功的话，需要在这个地方切换界面、
                    //发送通知让appdelegata切换控制器
                    NotificationCenter.default.post(name: NSNotification.Name( HMChangeRootVCNotification), object: self)
                }else{
                    print("登录失败")
                }
            })
        }
        
        return false
    }
    
    
    //以下三个方法是webview的代理方法,需要遵守代理,设置代理属性
    //用SVProgressHUD设置加载的转圈
    //开始加载的时候
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    //结束加载的时候
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    //加载失败的时候
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    //懒加载webview
    lazy var webView :UIWebView = {
        
        let webView = UIWebView()
        webView.delegate = self
        return webView
    }()

    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
