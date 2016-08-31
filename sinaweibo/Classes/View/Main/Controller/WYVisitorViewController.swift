//
//  WYVisitorViewController.swift
//  sinaweibo
//
//  Created by 王云 on 16/8/30.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYVisitorViewController: UITableViewController {

    //定义属性来记录用户是登录状态还是未登录
    var userLogin = false
    
    //重写loadview的方法,加载我们要显示的视图
    override func loadView() {
        //如果是登录状态,那么正常显示
        if userLogin {
            super.loadView()
        }else
            //如果没有登录,那么加载我们自己定义的view
        {
            setupView()
            
        }
    }
    
    //初始化UI
    func setupView () {
        let v = self.visitorView
        //v.backgroundColor = UIColor.white
        self.view = v
        //v.backgroundColor = UIColor.lightGray
    }
    
    //懒加载view
    lazy var visitorView :WYVisitorView = {
        
        let visitorView = WYVisitorView()
        
        return visitorView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        navigationItem.leftBarButtonItem = UIBarButtonItem( title: "注册", target: self, action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", target: self
            , action: #selector(visitorViewWillLogin))
        
        //如何不通过代理监听点击
        //直接取到视图里的控件监听
        visitorView.loginBtn.addTarget(self, action: #selector(visitorViewWillLogin), for: UIControlEvents.touchUpInside)
        
        
    }

    func visitorViewWillLogin () {
        
        print("哈哈哈哈哈")
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
