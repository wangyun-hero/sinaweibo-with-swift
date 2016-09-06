//
//  WYRefreshControlH.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/5.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

/// 定义刷新控件的三种状态
///
/// - normal:     <#normal description#>
/// - pulling:    <#pulling description#>
/// - refreshing: <#refreshing description#>
enum WYRefreshType: String {
    case normal = "normal"      // 默认状态，没有拖动或者拖动的没有将当前控件完全显示出来
    case pulling = "pulling"    // 松手就可以刷新的状态，代表当前控件已经完全显示出来了
    case refreshing = "refreshing"  // 刷新中的状态
}


private let HMRefreshControlH: CGFloat = 50

class WYRefreshControl: UIControl {

    //刷新的状态
    var refreshState : WYRefreshType = .normal
    //记录父控件(也就是记录tableview)
    var scrollview : UIScrollView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        //判断类型
        if newSuperview is UIScrollView {
            //记录父控件
            self.scrollview = newSuperview as! UIScrollView
            //添加观察者
            self.scrollview?.addObserver(self, forKeyPath: "contentOffset", options: [.new], context: nil)
        }
    }
    
    //移除观察者,否则崩溃
    deinit {
        self.scrollview?.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    //当tableview的contentOffset改变的时候会调用这个方法
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //通过观察,当self.scrollview?.contentOffset <= -114的时候,刷新控件就完全显露出来
        print(self.scrollview?.contentOffset)
        //相当于64的高度
        let contentInsetTop  = self.scrollview!.contentInset.top
        //-114
        let conditionValue :CGFloat = -contentInsetTop - HMRefreshControlH
        
        //用户在拖动
        if (scrollview?.isDragging)! {
            //当刷新状态是默认状态并且offsetY小于114的时候
            if refreshState == .normal && self.scrollview!.contentOffset.y < conditionValue {
                print("进入松手就刷新的状态")
                self.refreshState = .pulling
            }else if refreshState == .pulling && self.scrollview!.contentOffset.y > conditionValue {
                print("进入到默认状态")
                self.refreshState = .normal
            }
           
        }else{
            //用户没有拖动
            if refreshState == .pulling {
                refreshState = .refreshing
            }
            
            
            
        }
        
        
        
        
        
    }
    
    
    
    func setupUI () {
        backgroundColor = UIColor.orange
        frame.size = CGSize(width: HMScreenW, height: HMRefreshControlH)
        frame.origin.y = -HMRefreshControlH
        
        //添加下拉刷新的控件
        addSubview(arrowIcon)
        addSubview(messageLabel)
        
        //约束
        arrowIcon.snp_makeConstraints { (make ) in
            make.centerX.equalTo(self).offset(-35)
            make.centerY.equalTo(self)
        }
        messageLabel.snp_makeConstraints { (make ) in
            make.leading.equalTo(arrowIcon.snp_trailing)
            make.centerY.equalTo(arrowIcon)
        }
        
        
    }
    
    
    
    //懒加载控件
    lazy var arrowIcon : UIImageView = UIImageView(image: UIImage(named:"tableview_pull_refresh"))

    lazy var messageLabel :UILabel = {
        
        let messageLabel = UILabel(textColour: UIColor.black, fontSize: 12)
        messageLabel.text = "等待起飞"
        return messageLabel
    }()

}
