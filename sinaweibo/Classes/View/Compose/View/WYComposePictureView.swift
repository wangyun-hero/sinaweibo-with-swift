//
//  WYComposePictureView.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/9.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit
import SVProgressHUD
class WYComposePictureView: UICollectionView {
    //懒加载一个数组保存图片
    lazy var images:[UIImage] = [UIImage]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI () {
        //注册cell
        self.register(WYComposePictureViewCell.self, forCellWithReuseIdentifier: "cell")
        //设置数据源
        self.dataSource = self
    }
    
    func addImage(image:UIImage) {
        if images.count < 9 {
            //将图片添加到数组
            images.append(image)
            self.reloadData()
        }
        else{
            SVProgressHUD.showError(withStatus: "图片数量超出限制")
        }
    }
    
    //设置流水布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let itemMargin : CGFloat = 5
        let itemW = (self
        .frame.width - 2 * itemMargin) / 3
        
        //取到布局对象
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        //大小
        layout.itemSize = CGSize(width: itemW, height: itemW)
        //间距
        layout.minimumLineSpacing = itemMargin
        layout.minimumInteritemSpacing = itemMargin
    }

}

// MARK: - 数据源
extension WYComposePictureView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WYComposePictureViewCell
        //cell.backgroundColor = RandomColor
        //取到对应位置的图片
        let image = images[indexPath.item]
        //设置给cell
        cell.image = image
        
        //定义一个闭包
        cell.deleteClickClosure = {[weak self]
            () -> () in
            self?.images.remove(at: indexPath.item)
        //刷新数据
            self?.reloadData()
        }
        
        return cell
    }
    
}


class WYComposePictureViewCell: UICollectionViewCell {
    //删除按钮执行的闭包
    var deleteClickClosure: (() -> ())?
    
    //通过外界传值设置image图片
    var image : UIImage? {
        
        didSet{
            imageView.image = image
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        //添加控件
        contentView.addSubview(imageView)
        contentView.addSubview(deleteButton)
        //约束
        imageView.snp_makeConstraints { (make ) in
            make.edges.equalTo(contentView)
        }
        deleteButton.snp_makeConstraints { (make ) in
            make.top.right.equalTo(contentView)
        }
    }
    
    func deleteButtonClick() {
        print("点击了删除")
        //执行闭包,因为我们要删除images里面的元素,在这里娶不到,那么我们就要告诉pictureview
        deleteClickClosure?()
    }
    
    
    //MARK: - 懒加载控件
     lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    //删除的叉叉
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(deleteButtonClick), for: UIControlEvents.touchUpInside)
        button.setImage(UIImage(named:"compose_photo_close"), for: UIControlState.normal)
        return button
    }()
    
    
}









