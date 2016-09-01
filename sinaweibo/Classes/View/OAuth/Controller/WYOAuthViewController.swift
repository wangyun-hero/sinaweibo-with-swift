//
//  WYOAuthViewController.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/1.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit
import SVProgressHUD

private let WB_APPKEY = "2367628679"
private let WB_SECRET = "7c6e35f40cf8dde1131ac63e35e94305"
private let WB_REDIRECT_URI = "http://www.itheima.com/"

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
