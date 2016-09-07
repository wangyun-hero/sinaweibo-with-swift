//
//  WYTabBarController.swift
//  sinaweibo
//
//  Created by 王云 on 16/8/29.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYTabBarController: UITabBarController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //自定义一个tabbar
        let tabbar = WYTabBar()
        
        //准备好一个闭包,当底部 + 号被点击的时候将事件传递
        tabbar.closure = {
            () -> () in
            print("加按钮被点击,弹出菜单")
            let v = WYComposeView()
            v.show()
        }
        
        // 值  键(属性) 相当于把创建的tabbar赋值给控制器的TabBar
        self.setValue(tabbar, forKey: "TabBar")
        
        addChildViewControllers()

        
    }
    
    
    func addChildViewControllers() {
        addChildViewController(vc: WYHomeTableViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(vc: WYMessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(vc: WYDiscoverTableViewController(), title: "发现", imageName: "tabbar_discover")
        
        addChildViewController(vc: WYProfileTableViewController(), title: "我的", imageName: "tabbar_profile")
        
        
    }
    
    
    //设置某个控制器的标题,图片,字体颜色,并且嵌套一个导航控制器
    func addChildViewController (vc:UIViewController, title:String , imageName: String) {
        //设置控制器的标题
        vc.title = title
        //设置图标
        vc.tabBarItem.image = UIImage(named:imageName)
        //设置被选中的图标
        vc.tabBarItem.selectedImage = UIImage(named:"\(imageName)_selected")
        //设置渲染的颜色
//        vc.tabBarController?.tabBar.tintColor = UIColor.red
       // vc.tabBarController?.tabBar.barTintColor = UIColor.red
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orange], for: UIControlState.selected)
      
        //每个控制器需要包裹一个导航控制器
        let nav = WYNavigationController(rootViewController: vc)
        // 将导航控制器添加到tabBarVc里面 ???????????????
        addChildViewController(nav)
    }
    
    
    
    
    
    

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
