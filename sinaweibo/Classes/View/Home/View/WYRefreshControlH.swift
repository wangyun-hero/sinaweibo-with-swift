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
    var refreshState : WYRefreshType = .normal {
        
        didSet {
            switch refreshState {
            case .pulling:
                // 调转箭头
                UIView.animate(withDuration: 0.25, animations: {
                    self.arrowIcon.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI))
                })
                self.messageLabel.text = "松开起飞"
            case .normal:
                //关闭菊花转
                indicatorView.stopAnimating()
                //箭头显示出来
                arrowIcon.isHidden = false
                UIView.animate(withDuration: 0.25, animations: {
                    self.arrowIcon.transform = CGAffineTransform.identity
                })
                self.messageLabel.text = "等待起飞"
                
                // 判断如果之前是刷新状态的话，才去执行下面的代码
                if oldValue == .refreshing {
                    // 把inset移回去
                    UIView.animate(withDuration: 0.25, animations: {
                        // 如果让其在转的时候停止在界面的顶端
                        // 为tableView顶部增加多余的滑动距离
                        var inset = self.scrollview!.contentInset
                        inset.top -= HMRefreshControlH
                        self.scrollview!.contentInset = inset
                    })
                }

                
            case .refreshing:
                arrowIcon.isHidden = true
//indicatorView.isHidden = false
                indicatorView.startAnimating()
                self.messageLabel.text = "正在起飞"
            
                UIView.animate(withDuration:
                    1, animations: {
                        // 如果让其在转的时候停止在界面的顶端
                        // 为tableView顶部增加多余的滑动距离
                        var inset = self.scrollview!.contentInset
                        inset.top += HMRefreshControlH
                        self.scrollview?.contentInset = inset

                })
                
            // 发送事件，其实就是调用addTarget里面的方法
            sendActions(for: UIControlEvents.valueChanged)

            }

        }
        
    }
    //停止刷新
    func endRefreshing() {
        refreshState = .normal
    }
    
    
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
            self.scrollview = newSuperview as? UIScrollView
            //添加观察者
            self.scrollview?.addObserver(self, forKeyPath: "contentOffset", options: [.new], context: nil)
        }
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
        if scrollview!.isDragging {
            //当刷新状态是默认状态并且offsetY小于114的时候
            if refreshState == .normal && self.scrollview!.contentOffset.y <= conditionValue {
                print("进入松手就刷新的状态")
                self.refreshState = .pulling
            }else if refreshState == .pulling && self.scrollview!.contentOffset.y > conditionValue {
                print("进入到默认状态")
                self.refreshState = .normal
            }
        // idDragging 代表用户是否在拖动
                }else{
            //用户没有拖动
            if refreshState == .pulling {
                refreshState = .refreshing
            }
           
        }
       
    }
    //移除观察者,否则崩溃
    deinit {
        self.scrollview?.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    
    func setupUI () {
        backgroundColor = UIColor.orange
        frame.size = CGSize(width: HMScreenW, height: HMRefreshControlH)
        frame.origin.y = -HMRefreshControlH
        
        //添加下拉刷新的控件
        addSubview(arrowIcon)
        addSubview(messageLabel)
        addSubview(indicatorView)
        
        //约束
        arrowIcon.snp_makeConstraints { (make ) in
            make.centerX.equalTo(self).offset(-35)
            make.centerY.equalTo(self)
        }
        messageLabel.snp_makeConstraints { (make ) in
            make.leading.equalTo(arrowIcon.snp_trailing)
            make.centerY.equalTo(arrowIcon)
        }
        indicatorView.snp_makeConstraints { (make ) in
            make.center.equalTo(arrowIcon)
        }
        
    }
    
    
    
    //懒加载控件
    lazy var arrowIcon : UIImageView = UIImageView(image: UIImage(named:"tableview_pull_refresh"))

    lazy var messageLabel :UILabel = {
        
        let messageLabel = UILabel(textColour: UIColor.black, fontSize: 12)
        messageLabel.text = "等待起飞"
        return messageLabel
    }()
    
    //菊花转
    lazy var indicatorView :UIActivityIndicatorView = {
        
        let indicatorView = UIActivityIndicatorView()
        indicatorView.color = UIColor.black
        //indicatorView.isHidden = true
        return indicatorView
    }()


}
