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
    
    
    //添加提示框
    self.navigationController?.view.insertSubview(pullDownTipLabel, belowSubview: (self.navigationController?.navigationBar)!)
    //设置提示框的y值
    pullDownTipLabel.frame.origin.y = (self.navigationController?.navigationBar.frame.maxY)! -  pullDownTipLabel.frame.height
    
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
    
    // UITableViewController身上有一个属性，该属性就是刷新控件的属性
//    self.refreshControl = UIRefreshControl()
//    self.refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    
    //将下拉刷新控件添加到tableview
    self.tableView.addSubview(wyRefreshControl)
    wyRefreshControl.addTarget(self, action: #selector(loadData), for: UIControlEvents.valueChanged)
    
    }
    
    func loadData () {
        homeViewModel.loadData(isPullUp: pullUpView.isAnimating) { (isSuccess,count) in
            if isSuccess  {
                //刷新数据
                self.tableView.reloadData()
                
            }else
            {
                print("加载错误")
            }
            
            //       测试       //
            print("加载回来\(count)条")
            
            // 如果不是上拉加载，才去显示这个label
            if !self.pullUpView.isAnimating{
                self.showTipLabel(count: count)
                
            }
            
            
            // 结束刷新
            self.pullUpView.stopAnimating()

//            self.refreshControl?.endRefreshing()
            self.wyRefreshControl.endRefreshing()
            
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
     lazy var pullUpView: UIActivityIndicatorView = {
        let pullUpView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        // 设置颜色
        pullUpView.color = UIColor.black
        
        return pullUpView
    }()

    //懒加载顶部的下啦刷新控件
    lazy var wyRefreshControl : WYRefreshControl = WYRefreshControl()
    
    lazy var pullDownTipLabel :UILabel = {
        
        let label = UILabel(textColour: UIColor.white, fontSize: 12)
        //背景颜色
        label.backgroundColor = UIColor.blue
        //居中
        label.textAlignment = .center
        //隐藏
        label.isEnabled = true
        //大小
        label.frame.size = CGSize(width: HMScreenW, height: 35)
        return label
    }()

    
    func showTipLabel(count:Int) {
        //解决重复下拉pullDownTipLabel显示不正常的问题
//        if pullDownTipLabel.isHidden == false {
//            return
//        }
        
        //让label显示出来
        pullDownTipLabel.isHidden = false
        //要显示的字符串
        let str = count == 0 ? "没有数据" : "\(count)条微博数据"
        //设置显示的字符串
        pullDownTipLabel.text = str
        
        UIView.animate(withDuration: 1, animations: {
            self.pullDownTipLabel.transform = CGAffineTransform.init(translationX: 0, y: self.pullDownTipLabel.frame.height)
            }) { (_) in
             UIView.animate(withDuration: 1, delay: 1, options: [], animations: {
                self.pullDownTipLabel.transform = CGAffineTransform.identity
                }, completion: { (_) in
                    self.pullDownTipLabel.isHidden = true
             })
        }
       
    }
    
    
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



