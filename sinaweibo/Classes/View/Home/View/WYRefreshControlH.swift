//
//  WYRefreshControlH.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/5.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

private let HMRefreshControlH: CGFloat = 50
class WYRefreshControl: UIControl {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI () {
        backgroundColor = UIColor.orange
        frame.size = CGSize(width: HMScreenW, height: HMRefreshControlH)
        frame.origin.y = -HMRefreshControlH
    }

}
