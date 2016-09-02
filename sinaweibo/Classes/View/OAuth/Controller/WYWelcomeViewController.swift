//
//  WYWelcomeViewController.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/2.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit
import SDWebImage
class WYWelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        //图片的url地址
        let url = URL(string: (HMUserAccountViewModel.sharedModel.account?.profile_image_url)!)
        //设置欢迎页 的头像
        imageView.sd_setImage(with: url)
        
        
    }

    func setupUI () {
        self.view.backgroundColor = UIColor(white: 237/255, alpha: 1)
        //添加控件
        view.addSubview(imageView)
        view.addSubview(messageLabel)
        
        //约束
        imageView.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSize(width: 90, height: 90))
            make.top.equalTo(200)
            make.centerX.equalTo(self.view)
        }
        
        messageLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(imageView)
            make.top.equalTo(imageView.snp_bottom).offset(15)
        }
   
    }
    
    //加载头像的动画
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //先更新约束 update
        //做动画 layoutifneeded
        imageView.snp_makeConstraints { (make) in
            make.top.equalTo(100)
        }
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            self.view.layoutIfNeeded()
            }) { (_) in
                UIView.animate(withDuration: 1, animations: {
                    self.messageLabel.alpha = 1
                    }, completion: { (_) in
                        
                })
        }
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    //懒加载控件
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "avatar_default"))
        
        // 设置圆角
        imageView.layer.cornerRadius = 45;
        imageView.layer.masksToBounds = true;
        // 设置边线
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1
        
        return imageView
    }()
    
    private lazy var messageLabel:UILabel = {
        let label = UILabel(textColour: UIColor.darkGray, fontSize: 16)
        label.alpha = 0
        label.text = "欢迎回来"
        return label
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
