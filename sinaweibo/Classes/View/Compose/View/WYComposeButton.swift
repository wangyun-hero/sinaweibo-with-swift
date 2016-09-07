//
//  WYComposeButton.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/7.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYComposeButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    func setupUI() {
        imageView?.contentMode = .center
        //文字居中
        titleLabel?.textAlignment = .center
    }
    
    func test() {
        print("ssss")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let width = self.frame.width
        let height = self.frame.height
        
        imageView?.frame = CGRect(x: 0, y: 0, width: width, height: width)
        titleLabel?.frame = CGRect(x: 0, y: width, width: width, height: height - width)
    }
    
}
