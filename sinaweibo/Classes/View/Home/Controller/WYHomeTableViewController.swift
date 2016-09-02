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

    //用全局属性记录模型数组
    var statusArray: [WYStatus]?
    
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
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
    
    //点击右边item跳转
    navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(pop))
    
    }
    
    //加载数据
    func loadData () {
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
            self.tableView.reloadData()
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
        return statusArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       //取到对应位置的模型
        let model = statusArray![indexPath.row]
        //设置数据
        cell.textLabel?.text = model.text
        
        return cell
    }
  
}



