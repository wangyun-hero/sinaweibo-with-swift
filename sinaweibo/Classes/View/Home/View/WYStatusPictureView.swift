//
//  WYStatusPictureView.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/4.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYStatusPictureView: UICollectionView {

    var pic_urls: [WYStatusPictureInfo]? {
        
        didSet {
            
        }
        
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI () {
        backgroundColor = UIColor.red
    }
    

}
