//
//  WYTempViewController.swift
//  sinaweibo
//
//  Created by 王云 on 16/8/30.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYTempViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置控制器的颜色
        view.backgroundColor = UIColor.white
        
//        //设置左边的item
//        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_back_withtext", title: "返回", target: self, action: #selector(back))
        
        //设置右边的item
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "PUSH", target: self, action: #selector(push))
        
    }
    
//    //点击左边item执行pop
//    func back () {
//        _ = navigationController?.popViewController(animated: true)
//    }

    
    //点击右边的item执行push
    func push (){
        let vc = WYTempViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
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
