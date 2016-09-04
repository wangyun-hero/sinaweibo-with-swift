//
//  WYStatusCell.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/3.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

// cell里面共有的间距
let HMStatusCellMargin: CGFloat = 10

class WYStatusCell: UITableViewCell {

//    var status : WYStatus? {
//        didSet{
//            nameLabel.text = status?.text
//        }
//        
//    }
    
//    var statusViewmodel : WYStatusViewModel? {
//        didSet {
//            nameLabel.text = statusViewmodel?.status?.text
//        }
//    }
    
    var statusViewmodel : WYStatusViewModel? {
        didSet {
            //当控制器给cell设置数据的时候,就将数据传递给originalview.然后可以设置给子视图
            originalView.statusViewModel = statusViewmodel
            statusToolBar.statusViewModel = statusViewmodel
            
            //判断是否有转发微博
            if statusViewmodel?.status?.retweeted_status != nil {
                //显示转发的微博
                retweetView.isHidden = false
                //数据传递过去
                retweetView.statusViewModel = statusViewmodel
                
                statusToolBar.snp_remakeConstraints(closure: { (make ) in
                    make.left.right.bottom.equalTo(contentView)
                    make.height.equalTo(35)
                    make.top.equalTo(retweetView.snp_bottom)
                })
            }
            else
            {
               retweetView.isHidden = true
                // 没有转发微博，toolBar的顶部就为原创微博的顶部
               statusToolBar.snp_remakeConstraints(closure: { (make) in
                make.top.equalTo(originalView.snp_bottom)
                make.left.right.bottom.equalTo(contentView)
                make.height.equalTo(35)
               })
               
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //重写构造方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    func setupUI () {
        //添加原创微博的view
        contentView.addSubview(originalView)
        //添加底部工具条
        contentView.addSubview(statusToolBar)
        //添加中间转发的微博
        contentView.addSubview(retweetView)
        
        //添加约束
        originalView.snp_makeConstraints { (make ) in
            make.left.top.right.equalTo(contentView)
            
        }
        
        retweetView.snp_makeConstraints { (make) in
            make.left.right.equalTo(originalView)
            make.top.equalTo(originalView.snp_bottom)
            
        }
        
        statusToolBar.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(contentView)
            make.height.equalTo(35)
            make.top.equalTo(retweetView.snp_bottom)
        }
        
        
        
//        //添加控件
//       contentView.addSubview(nameLabel)
//        //添加约束
//        nameLabel.snp_makeConstraints { (make ) in
//            make.centerY.equalTo(contentView)
//            make.left.equalTo(contentView).offset(10)
//        }
    }
    
    //懒加载原创的view
    // 当前cell里面管理三个子控件：原创微博的视图，转发微博的视图，底部的工具条
 private  lazy var originalView :WYOriginalStatusView = WYOriginalStatusView()
    
    lazy var statusToolBar : WYStatusToolBar = WYStatusToolBar()

    lazy var retweetView : WYRetweetStatusView = WYRetweetStatusView()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
