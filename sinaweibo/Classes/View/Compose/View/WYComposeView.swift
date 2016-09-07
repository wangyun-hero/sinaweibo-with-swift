//
//  WYComposeView.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/7.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit
import pop
class WYComposeView: UIView {
    
    //懒加载一个button的数组
    lazy var buttons: [UIButton] = [UIButton]()

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
            
            //将button添加到数组当中
            buttons.append(button)
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        //反转遍历
        for (index,button) in buttons.reversed().enumerated() {
            anim(button: button, index: index, isUp: false)
//            //执行动画,kPOPViewCenter代表移动的是btn的centre
//            let anim = POPSpringAnimation(propertyNamed: kPOPViewCenter)
//            //移动到哪里
//            anim?.toValue = NSValue.init(cgPoint: CGPoint(x: button.center.x, y: button.center.y + 350))
//            //阻尼系数
//            anim?.springBounciness = 10
//            //速度
//            anim?.springSpeed = 12
//            //让六个按钮以先后顺序出来
//            anim?.beginTime = CACurrentMediaTime() + Double(index) * 0.025
//            button.pop_add(anim, forKey: nil)
        }
        
        //从现在开始加0.4秒之后移除
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
            //移除
            self.removeFromSuperview()
        }
        
    }
    
    
    //提供一个方法给外界调用
    func show() {
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
       
        //取到button来做动画
        for (index,button) in buttons.enumerated() {
            anim(button: button, index: index, isUp: true)
//            //执行动画,kPOPViewCenter代表移动的是btn的centre
//            let anim = POPSpringAnimation(propertyNamed: kPOPViewCenter)
//            //移动到哪里
//            anim?.toValue = NSValue.init(cgPoint: CGPoint(x: button.center.x, y: button.center.y - 350))
//            //阻尼系数
//            anim?.springBounciness = 10
//            //速度
//            anim?.springSpeed = 12
//            //让六个按钮以先后顺序出来
//            anim?.beginTime = CACurrentMediaTime() + Double(index) * 0.025
//            button.pop_add(anim, forKey: nil)
        }
        
    }
    
    //上面两个方法高度重合,我们抽一个方法出来
    func anim(button : UIButton ,index : Int , isUp : Bool) {
        let anim = POPSpringAnimation(propertyNamed:kPOPViewCenter)
        anim?.toValue = NSValue.init(cgPoint: CGPoint(x: button.center.x, y: button.center.y + (isUp ? -350 : 350)))
        //阻尼系数
        anim?.springBounciness = 10
        //速度
        anim?.springSpeed = 12
        anim?.beginTime = CACurrentMediaTime() + Double(index) * 0.025
        button.pop_add(anim, forKey: nil)

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
