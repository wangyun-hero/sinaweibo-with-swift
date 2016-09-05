//
//  WYHomeTableViewController.swift
//  sinaweibo
//
//  Created by 王云 on 16/8/29.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit
import YYModel
class WYHomeTableViewController: WYVisitorViewController {
    
    lazy var homeViewModel: WYHomeViewModel = WYHomeViewModel()

    //用全局属性记录模型数组
    //var statusArray: [WYStatus]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if userLogin == false {
            visitorView.setvisitorViewInfo(imageName: nil, message: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
       setupUI()
       loadData()
        
    }
    
    
  private  func setupUI () {
        //本身并不提供设置图片的方法,我们将设置btn,然后设置到 UIBarButtonItem   的costomview上
//        let button = UIButton()
//        button.setImage(#imageLiteral(resourceName: "navigationbar_friendsearch"), for: UIControlState.normal)
//        button.setImage(#imageLiteral(resourceName: "navigationbar_friendsearch_highlighted"), for: UIControlState.highlighted)
//        button.sizeToFit()
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendsearch", target: nil, action: nil)
    
    //注册cell
    tableView.register(WYStatusCell.self, forCellReuseIdentifier: "cell")
    //行高自动计算
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 500
    
    //取消分割线
    tableView.separatorStyle = .none
    
    //设置footview
    tableView.tableFooterView = pullUpView
    
    //点击右边item跳转
    navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(pop))
    
    }
    
    func loadData () {
        homeViewModel.loadData(isPullUp: pullUpView.isAnimating) { (isSuccess) in
            if isSuccess  {
                //刷新数据
                self.tableView.reloadData()
                
            }else
            {
                print("加载错误")
            }
            
            // 结束刷新
            self.pullUpView.stopAnimating()

        }
        
    }
        
     
    
//    //加载数据
//    func loadData () {
//        //url地址
//       let urlString = "https://api.weibo.com/2/statuses/friends_timeline.json"
//        //请求的参数
//        let params = [
//            "access_token": HMUserAccountViewModel.sharedModel.accessToken ?? ""
//        ]
//
//        //自己封装的网络请求工具类发起请求
//        HMNetworkTools.sharedTools.request(method: .Get, urlString: urlString, parameters: params) { (response, error) in
//            if (response == nil || error != nil) {
//                print("请求错误\(error)")
//                return
//            }
//            
//            print(response)
//            //对数据进行解析
//            //
//            guard let dictArray = (response! as! [String: Any])["statuses"] as? [[String: Any]] else {
//                return
//            }
//            //字典转模型
//            let modelArray = NSArray.yy_modelArray(with: WYStatus.classForCoder(), json: dictArray) as? [WYStatus]
//            //赋值给全局属性
//            self.statusArray = modelArray
//            //刷新数据源
//            self.tableView.reloadData()
//        }
//     
//    }
    
    //懒加载底部的菊花转
//    lazy var pullupView : UIActivityIndicatorView = {
//        let pullupView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
//        
//        pullupView.backgroundColor = UIColor.orange
//        return pullupView
//    }()
     lazy var pullUpView: UIActivityIndicatorView = {
        let pullUpView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        // 设置颜色
        pullUpView.color = UIColor.black
        
        return pullUpView
    }()

    
    
    
    func pop(){
        print(#function)
        let vc = WYTempViewController()
        //vc.navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_back_withtext", title: "返回", target: self, action: #selector(back))
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func back () {
       _ = navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//数据源方法
extension WYHomeTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.statusArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WYStatusCell
       //取到对应位置的模型
        let model = homeViewModel.statusArray![indexPath.row]
        //设置数据
        cell.statusViewmodel = model
        
        return cell
    }
    
    //代理方法
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //上拉刷新,为了避免用户重复的上拉.添加判断条件pullUpView.isAnimating == false
        if indexPath.row == homeViewModel.statusArray!.count - 1 && pullUpView.isAnimating == false {
            print("将要上啦刷新")
            //启动
            self.pullUpView.startAnimating()
            self.loadData()
        }
    }
    
  
}



