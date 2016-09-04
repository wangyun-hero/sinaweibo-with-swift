//
//  WYOriginalStatusView.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/3.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYOriginalStatusView: UIView {
    
    var bottonCons : Constraint?
    
    var statusViewModel : WYStatusViewModel? {
        
        didSet{
            //时间与来源暂时不处理
            
            iconView.sd_setImage(with: URL(string:statusViewModel?.status?.user?.profile_image_url ?? ""), placeholderImage: #imageLiteral(resourceName: "avatar_default"))
            
            nameLabel.text = statusViewModel?.status?.user?.name
            
           // memberIconView
            memberIconView.image = statusViewModel?.memberImage
            
            avatarView.image = statusViewModel?.avatarImage
            
            contentLabel.text = statusViewModel?.status?.text
            
            bottonCons?.uninstall()
            
            if let pic_urls = statusViewModel?.status?.pic_urls, pic_urls.count > 0 {
                
                // 代表有图片
                pictureView.isHidden = false
                // 要给配图控件设置数据
                pictureView.pic_urls = pic_urls
                // 要给配图控件设置数据
                pictureView.pic_urls = pic_urls
                self.snp_updateConstraints { (make) -> Void in
                    bottonCons = make.bottom.equalTo(pictureView).offset(HMStatusCellMargin).constraint
                }

            }
            else
            {
                // 代表没图片
                pictureView.isHidden = true
                
                self.snp_updateConstraints { (make) -> Void in
                    bottonCons = make.bottom.equalTo(contentLabel).offset(HMStatusCellMargin).constraint
                }

            }
            
        }
        
    }

   override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func setupUI () {
        
        // 1. 添加控件
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(memberIconView)
        addSubview(createAtLabel)
        addSubview(sourceLabel)
        addSubview(avatarView)
        addSubview(contentLabel)
        addSubview(pictureView)
        
        // 2. 添加约束
        iconView.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(HMStatusCellMargin)
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
        
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconView)
            make.left.equalTo(iconView.snp_right).offset(HMStatusCellMargin)
        }
        
        memberIconView.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp_right).offset(HMStatusCellMargin)
        }
        
        createAtLabel.text = "刚刚"
        createAtLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(iconView)
        }
        
        sourceLabel.text = "来自 隔壁的老王"
        sourceLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(createAtLabel.snp_right).offset(HMStatusCellMargin)
            make.top.equalTo(createAtLabel)
        }
        
        avatarView.snp_makeConstraints { (make) in
            make.centerY.equalTo(iconView.snp_bottom).offset(-2)
            make.centerX.equalTo(iconView.snp_right).offset(-2)
        }
        
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(iconView)
            make.top.equalTo(iconView.snp_bottom).offset(HMStatusCellMargin)
        }
        
        //约束
        pictureView.snp_makeConstraints { (make ) in
            make.top.equalTo(contentLabel.snp_bottom).offset(HMStatusCellMargin)
            make.leading.equalTo(contentLabel)
        }

        // 将原创微博的底部设置到内容的底部
        self.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(pictureView).offset(HMStatusCellMargin)
        }

        
        
        
        
        
        
        
    }
    
    //懒加载控件
    // 头像
    private lazy var iconView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "avatar_default"))
    // 昵称
    private lazy var nameLabel: UILabel = {
        let label = UILabel(textColour: UIColor.darkGray, fontSize: 14)
        label.text = "老王"
        return label
    }()
    // 会员图标
    private lazy var memberIconView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "common_icon_membership"))
    // 创建时间
    private lazy var createAtLabel: UILabel = UILabel(textColour: UIColor.orange, fontSize: 12)
    // 来源
    private lazy var sourceLabel: UILabel = UILabel(textColour: UIColor.darkGray, fontSize: 12)
    // 认证的图标
    private lazy var avatarView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "avatar_vgirl"))
    // 内容的label
    private lazy var contentLabel: UILabel = {
        let label = UILabel(textColour: UIColor.darkGray, fontSize: 15)
        // 设置多行模式
        label.numberOfLines = 0
        // 告诉系统，最大的布局宽度是多少
        label.preferredMaxLayoutWidth = HMScreenW - 2 * HMStatusCellMargin
        return label
    }()

    //配图视图
    private lazy var pictureView : WYStatusPictureView = WYStatusPictureView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    
    

}
