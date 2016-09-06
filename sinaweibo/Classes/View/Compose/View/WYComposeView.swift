//
//  WYComposeView.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/7.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYComposeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        //高斯模糊
//        let image = getScreenSnap()?.applyLightEffect()
        self.backgroundColor = UIColor.red
        self.frame = UIScreen.main.bounds
        
        //添加背景图
        addSubview(bgImage)
        addSubview(sloganImage)
        
        //约束
        bgImage.snp_makeConstraints { (make ) in
            make.edges.equalTo(self)
        }
        
        sloganImage.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.top.equalTo(100)
        }

       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
    }
    
    
    // MARK: - 懒加载控件
    private lazy var bgImage: UIImageView = {
        let imaged = UIImage.getScreenSnap()?.applyLightEffect()
        let imageView = UIImageView(image: imaged)
        return imageView
    }()

    // compose_slogan
    private lazy var sloganImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "compose_slogan"))
        return imageView
    }()


}
