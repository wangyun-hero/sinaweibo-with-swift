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

        addChildButtons()
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
    }
    
    /// 添加子按钮
    func addChildButtons() {
        
        // 按钮的宽度
        let itemW: CGFloat = 80
        let itemH: CGFloat = 110
        // 求出每按钮之间的间距
        let itemMargin = (HMScreenW - 3 * itemW) / 4
        
        // 读取 compose.list
        let path = Bundle.main.path(forResource: "compose.plist", ofType: nil)!
        let array = NSArray(contentsOfFile: path)!
        
        for i in 0..<array.count {
            let button = WYComposeButton(textColour: UIColor.darkGray, fontSize: 14)
            
            // 取出对应位置的字典
            let dict = array[i] as! [String: String]
            // 设置图标与文字
            button.setImage(UIImage(named: dict["icon"]!), for: UIControlState.normal)
            button.setTitle(dict["title"]!, for: UIControlState.normal)
            // 设置大小
            button.frame.size = CGSize(width: itemW, height: itemH)
            
            // 1. 求出按钮在第几列
            let col = i % 3
            // 2. 求出按钮在第几行
            let row = i / 3
            
            // 通过列数求出x值
            let x = CGFloat(col) * itemW + CGFloat(col + 1) * itemMargin
            // 通过行数求出y值
            let y = CGFloat(row) * itemH + HMScreenH
            // 设置按钮的位置
            button.frame.origin = CGPoint(x: x, y: y)
            
            addSubview(button)
        }
        
        
    }
    
    private func test () {
        print("sss")
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
