//
//  WYComposeViewController.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/7.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit


class WYComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        //注册通知监听键盘的弹出
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(noti:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    //监听键盘的方法
    func keyboardWillChangeFrame(noti:Notification) {
        //print(noti)
        //取到键盘最终要停留的位置
        let frame = (noti.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        //取到键盘执行动画的时间
        let duration = (noti.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        //更新约束
        composeToolBar.snp_updateConstraints { (make ) in
            make.bottom.equalTo(self.view).offset(frame.origin.y - HMScreenH)
        }
        
        UIView.animate(withDuration: duration) { 
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    func back() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    //懒加载中间的label(用到富文本)的标题
    internal lazy var titleLabel : UILabel = {
        let label = UILabel()
        //换行
        label.numberOfLines = 0
        //居中
        label.textAlignment = .center
        if let name = HMUserAccountViewModel.sharedModel.account?.name {
            let title = "发微博\n\(name)"
            //初始化富文本
            let atrText = NSMutableAttributedString(string: title)
            // attrs:属性 range:范围
            //取到昵称字符串的范围,只有nsstring字符串的范围才是NSRange
            let range = (title as NSString).range(of: name)
            //编辑富文本
            atrText.addAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:UIColor.lightGray], range: range)
            label.attributedText = atrText
            
        }else{
            
            label.text = "发微博"
        }
        label.sizeToFit()
       return label
    }()
    
    //右边的button
    lazy var rightButton :UIButton = {
        
        let button = UIButton()
        //设置文字大小
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        //设置不同状态下的北京图片
    button.setBackgroundImage(UIImage(named:"common_button_orange"), for: .normal)
        button.setBackgroundImage(UIImage(named: "common_button_orange_highlighted"), for: UIControlState.highlighted)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: UIControlState.disabled)
        
        //不同状态下文字的颜色
        button.setTitleColor(UIColor.gray, for: UIControlState.disabled)
        button.setTitleColor(UIColor.red, for: UIControlState.normal)
        button.setTitle("发送", for: UIControlState.normal)
        // 设置按钮的大小
        button.frame.size = CGSize(width: 44, height: 30)

        return button
    }()
    
    //textView
    internal lazy var textView: WYTextView = {
        let textView = WYTextView()
        //设置占位文字
        textView.placeholder = "听说下雨天和黄焖鸡更配听说下雨天和黄焖鸡更配听说下雨天和黄焖鸡更配听说下雨天和黄焖鸡更配听说下雨天和黄焖鸡更配听说下雨天和黄焖鸡更配听说下雨天和黄焖鸡更配听说下雨天和黄焖鸡更配"
        //设置自己为代理来监听文字的输入
        textView.delegate = self
        //// 垂直方向总是有弹簧效果
        textView.alwaysBounceVertical = true
        //拖动textview的时候键盘消失
        textView.keyboardDismissMode = .onDrag
        //设置字体大小
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
    }()
    
    //懒加载底部的view
    lazy var composeToolBar : WYComposeToolBar = {
        let composeToolBar = WYComposeToolBar()
        //将控制器设置为composeToolBar的代理属性
        composeToolBar.delegata = self
        return composeToolBar
    }()
    
    //懒加载picture
    lazy var pictureView :WYComposePictureView = {
        
        let pictureView = WYComposePictureView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        pictureView.backgroundColor = UIColor.white
        return pictureView
    }()




    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//遵守协议,实现代理方法
extension WYComposeViewController:WYComposeToolBarDelegata {
    func composeToolBar(toolBar: WYComposeToolBar, type: ComposeToolBarButtonType)
    {
        switch type {
        case .picture:
            selectPicture()
        case .mention:
            print("@")
        case .trend:
            print("#")
        case .emotion:
            print("表情")
        case .add:
            print("+")
        }

    }
    
    func selectPicture () {
        //系统提供的选择照片的控制器
        let vc = UIImagePickerController()
        
        //成为代理
        vc.delegate = self
        
        //判断某个数据类型是否可用
        if UIImagePickerController.isSourceTypeAvailable(.camera) == false {
            print("相机不可用")
        }
        //来源  就是我们图片的来源  1 相机 2 图库 3 相册
        vc.sourceType = .photoLibrary
        
        //是否可以编辑,就是选择照片之后可以编辑
        vc.allowsEditing = true
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
}

//实现上面的代理方法
extension WYComposeViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //代理方法,实现代理方法imagevc就不会自动关闭了
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //取到对应的图片
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        //将图片添加到pictureview
        pictureView.addImage(image: image)
        //关闭imageVC
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}



extension WYComposeViewController:UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        //当textview有文字的时候右边item可用
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
    
    //下面方法同样能够实现拖动textView的时候键盘消失
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        // 取消第一响应者
//        // self.textView.resignFirstResponder()
//        self.view.endEditing(true)
//    }

    
    
}


//MARK: - 初始化界面

extension WYComposeViewController{
    func setupUI () {
        
        //背景颜色
        self.view.backgroundColor = UIColor.white
        //左边item
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(back))
        navigationItem.titleView = titleLabel
        
        //设置右边的item
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        // 默认设置为不可用
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        view.addSubview(textView)
        view.addSubview(composeToolBar)
        textView.addSubview(pictureView)
        
        //约束
        textView.snp_makeConstraints { (make ) in
            make.edges.equalTo(self.view)
        }
        composeToolBar.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(self.view)
            make.height.equalTo(44)
        }
        pictureView.snp_makeConstraints { (make ) in
            make.top.equalTo(textView).offset(100)
            make.left.equalTo(textView).offset(10)
            make.width.equalTo(textView.snp_width).offset(-20)
            make.height.equalTo(pictureView.snp_width)
        }
        
    }
    
    
    
}



