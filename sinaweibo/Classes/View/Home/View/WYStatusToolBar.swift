//
//  WYStatusToolBar.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/3.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYStatusToolBar: UIView {

    var retweetButton: UIButton!
    var commentButton: UIButton!
    var unlikeButton: UIButton!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func setupUI () {
        
        //添加三个按钮
        retweetButton = addChildButton(imageName: "timeline_icon_retweet", defaultTitle: "转发")
        commentButton = addChildButton(imageName: "timeline_icon_comment", defaultTitle: "评论")
        unlikeButton = addChildButton(imageName: "timeline_icon_unlike", defaultTitle: "赞")
        
        //添加两条线
        let sp1 = UIImageView(image: #imageLiteral(resourceName: "timeline_card_bottom_line"))
        let sp2 = UIImageView(image: #imageLiteral(resourceName: "timeline_card_bottom_line"))
        addSubview(sp1);addSubview(sp2)
        //约束
        retweetButton.snp_makeConstraints { (make) -> Void in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(commentButton.snp_width)
        }
        
        commentButton.snp_makeConstraints { (make) in
            make.left.equalTo(retweetButton.snp_right)
            make.top.bottom.equalTo(retweetButton)
            make.width.equalTo(unlikeButton.snp_width)
        }
        unlikeButton.snp_makeConstraints { (make) in
            make.right.top.bottom.equalTo(self)
            make.left.equalTo(commentButton.snp_right)
            make.width.equalTo(retweetButton.snp_width)
        }
        
        sp1.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(retweetButton.snp_right)
            make.centerY.equalTo(retweetButton)
        }
        
        sp2.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(commentButton.snp_right)
            make.centerY.equalTo(commentButton)
        }

        
    }
    
    
    func addChildButton (imageName:String,defaultTitle:String) -> UIButton {
       //创建btn
        let btn = UIButton()
        // 设置背景图片
        btn.setBackgroundImage(UIImage(named:"timeline_card_bottom_background"), for: .normal)
        btn.setBackgroundImage(UIImage(named:"timeline_card_bottom_background_highlighted"), for: .highlighted)
        
        //设置左边显示的图标
        btn.setImage(UIImage(named:imageName), for: .normal)
        //设置标题
        btn.setTitle(defaultTitle, for: .normal)
        //设置颜色
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        //设置字号
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        //添加到视图上
        addSubview(btn)
       
       return btn
    }
    

}
