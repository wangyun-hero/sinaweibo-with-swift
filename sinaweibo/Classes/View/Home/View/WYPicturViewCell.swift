//
//  WYPicturViewCell.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/4.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYPicturViewCell: UICollectionViewCell {
    
    var pictureInfo : WYStatusPictureInfo? {
        
        didSet {
            //设置图片
            imageView.sd_setImage(with: URL(string:pictureInfo?.thumbnail_pic ?? ""), placeholderImage: UIImage(named:"timeline_image_placeholder"))
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI () {
        //添加
        contentView.addSubview(imageView)
        //约束
        imageView.snp_makeConstraints { (make ) in
            make.edges.equalTo(contentView)
        }
        
    }
    
    lazy var imageView :UIImageView = {
        
        let imageView = UIImageView()
        //填充方式
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        //剪切
        imageView.clipsToBounds = true
        return imageView
    }()

    
    
}
