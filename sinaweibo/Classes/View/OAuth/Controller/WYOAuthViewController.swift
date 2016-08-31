//
//  WYOAuthViewController.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/1.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYOAuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "登录我的"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", target: self, action: #selector(close))
        print("一个测试")
        
        // Do any additional setup after loading the view.
    }
    
   @objc private func close () {
        self.dismiss(animated: true, completion: nil)
    
        
        
        
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
