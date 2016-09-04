//
//  WYRetweetStatusView.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/4.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYRetweetStatusView: UIView {
    
    var bottomCons : Constraint?
    
    var statusViewModel: WYStatusViewModel? {
        
        didSet {
            
            contentLabel.text = statusViewModel?.retweetStautsText
            
            //卸载约束
            self.bottomCons?.uninstall()
            
            //通过判断来显示或者隐藏配图的view
            if let pic_urls = statusViewModel?.status?.retweeted_status?.pic_urls,pic_urls.count > 0  {
                //有配图
                pictureView.isHidden = false
                //将数据传递到StatusPictureView
                pictureView.pic_urls = pic_urls
                self.snp_updateConstraints(closure: { (make ) in
                    //更新约束的前提是把对应的约束卸载掉,不然不能这么用
                    self.bottomCons = make.bottom.equalTo(pictureView).offset(HMStatusCellMargin).constraint
                })
                
            }
            else
            {
                //没有配图
                pictureView.isHidden = true
                
                self.snp_updateConstraints(closure: { (make ) in
                  self.bottomCons =  make.bottom.equalTo(contentLabel).offset(HMStatusCellMargin).constraint
                })
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
        self.backgroundColor = UIColor.gray
        addSubview(contentLabel)
        addSubview(pictureView)
        //约束
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.left.top.equalTo(self).offset(HMStatusCellMargin)
//            make.bottom.equalTo(self).offset(-HMStatusCellMargin)
        }
        
        // 约束配图
        pictureView.snp_makeConstraints { (make ) in
            make.left.equalTo(contentLabel)
            make.top.equalTo(contentLabel.snp_bottom).offset(HMStatusCellMargin)

            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        self.snp_makeConstraints { (make ) in
            make.bottom.equalTo(pictureView).offset(HMStatusCellMargin)
        }

        
    }
    
    // MARK: - 懒加载控件
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel(textColour: UIColor.darkGray, fontSize: 15)
        label.numberOfLines = 0
        // 设置的最大布局宽度
        label.preferredMaxLayoutWidth = HMScreenW - 2 * HMStatusCellMargin
        return label
    }()

    //懒加载配图视图

//   lazy var pictureView :WYStatusPictureView = WYStatusPictureView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var pictureView: WYStatusPictureView = {
        let view = WYStatusPictureView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = self.backgroundColor
        return view
    }()

    
}
