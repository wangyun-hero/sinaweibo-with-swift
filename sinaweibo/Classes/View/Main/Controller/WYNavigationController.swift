//
//  WYNavigationController.swift
//  sinaweibo
//
//  Created by 王云 on 16/8/30.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //设置左边的item
        if childViewControllers.count > 0 {
            
            var t = "返回"
            if childViewControllers.count == 1 {
                
                t = childViewControllers.first?.title ?? "返回"
            }
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_back_withtext", title: t, target: self, action: #selector(back))
            print("w")
        
        }
        //!!!!!!!!!!!!!!!!!  一定要调用
        super.pushViewController(viewController, animated: true)
    }

    //点击左边item执行pop
    func back () {
        _ = popViewController(animated: true)
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
