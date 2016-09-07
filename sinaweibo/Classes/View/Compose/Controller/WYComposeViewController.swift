//
//  WYComposeViewController.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/7.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func back() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    //懒加载中间的label(用到富文本)的标题
    internal lazy var titleLabel : UILabel = {
        let label = UILabel()
        //换行
        label.numberOfLines = 0
        //居中
        label.textAlignment = .center
        if let name = HMUserAccountViewModel.sharedModel.account?.name {
            let title = "发微博\n\(name)"
            //初始化富文本
            let atrText = NSMutableAttributedString(string: title)
            // attrs:属性 range:范围
            //取到昵称字符串的范围,只有nsstring字符串的范围才是NSRange
            let range = (title as NSString).range(of: name)
            //编辑富文本
            atrText.addAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:UIColor.lightGray], range: range)
            label.attributedText = atrText
            
        }else{
            
            label.text = "发微博"
        }
        label.sizeToFit()
       return label
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}

//MARK: - 初始化界面

extension WYComposeViewController{
    func setupUI () {
        
        //背景颜色
        self.view.backgroundColor = UIColor.white
        //左边item
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(back))
        
        
        navigationItem.titleView = titleLabel
    }
    
    
    
}



