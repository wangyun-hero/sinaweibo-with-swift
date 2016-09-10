//
//  WYEmoticonToolBar.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/10.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

/// 表情的类型
///
/// - RECENT:  最近
/// - DEFAULT: 默认
/// - EMOJI:   emoji
/// - LXH:     浪小花
enum HMEmotionType: Int {
    case RECENT = 0, DEFAULT, EMOJI, LXH
}


class WYEmoticonToolBar: UIView {
    
    var currentSelectedButton: UIButton?
    
    /// 表情类型切换按钮点击的时候执行的闭包
    var emotionTypeChangedClosure: ((HMEmotionType)->())?



    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

    func setupUI() {
        self.addSubview(stackView)
        stackView.snp_makeConstraints { (make ) in
            make.edges.equalTo(self)
        }
        //添加4个按钮
        addChildBtns(imageName: "compose_emotion_table_left", title: "最近",type: .RECENT)
        addChildBtns(imageName: "compose_emotion_table_mid", title: "默认",type:.DEFAULT)
        addChildBtns(imageName: "compose_emotion_table_mid", title: "Emoji",type:.EMOJI)
        addChildBtns(imageName: "compose_emotion_table_right", title: "浪小花",type:.LXH)

    }
    
    //添加按钮的方法
    private func addChildBtns (imageName:String , title:String ,type:HMEmotionType)  {
        //初始化button
        let button = UIButton()
        //设置tag
        button.tag = type.rawValue
        //监听按钮的点击
        button.addTarget(self, action: #selector(childButtonClick(btn:)), for: .touchUpInside)
        //设置标题
        button.setTitle(title, for: .normal)
        //设置字体颜色
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.gray, for: .selected)
        
        //设置背景图片
        button.setBackgroundImage(UIImage(named: "\(imageName)_normal"), for: UIControlState.normal)
        button.setBackgroundImage(UIImage(named: "\(imageName)_selected"), for: UIControlState.selected)
        stackView.addArrangedSubview(button)
    }
    
    // MARK: - 监听事件
    
    @objc private func childButtonClick(btn: UIButton) {
        
        // 判断当前点击的按钮与选中的按钮是同一个按钮的话，就不执行后面的代码
        if currentSelectedButton == btn {
            return
        }
        
        // 1. 让之前选中的按钮取消选中
        currentSelectedButton?.isSelected = false
        
        // 2. 让当前点击的按钮选中
        btn.isSelected = true
        
        // 3. 将当前选中的的按钮记录起来，记录起来原因是下次在点击其他按钮的时候，要取消当前按钮
        currentSelectedButton = btn
        
        // 4. 在这个地方通知外界去滚动collectionView
        // 也就是说需要在此执行一个闭包
        emotionTypeChangedClosure?(HMEmotionType(rawValue: btn.tag)!)
    }


    
    //MARK: - 懒加载控件
    private lazy var stackView :UIStackView = {
        
        let stackView = UIStackView()
        //设置布局方向
        stackView.distribution = .fillEqually
        return stackView
    }()

    
    
}
