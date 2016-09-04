//
//  WYRetweetStatusView.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/4.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYRetweetStatusView: UIView {
    
    var statusViewModel: WYStatusViewModel? {
        
        didSet {
            contentLabel.text = statusViewModel?.status?.retweeted_status?.text
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
        
        //约束
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.left.top.equalTo(self).offset(HMStatusCellMargin)
            make.bottom.equalTo(self).offset(-HMStatusCellMargin)
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

    

}
