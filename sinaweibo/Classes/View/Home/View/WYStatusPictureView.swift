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
            self.snp_updateConstraints { (make ) in
                make.size.equalTo(calcSize(count: pic_urls?.count ?? 0))
            }
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
    

    private func calcSize(count: Int) -> CGSize {
        
        let itemMargin: CGFloat = 5
        // 确定每一个条目的宽高
        let itemWH = (HMScreenW - 2 * HMStatusCellMargin - 2 * itemMargin) / 3
        
        // 要确定有多少列
        var col = count > 3 ? 3 : count
        if count == 4 {
            col = 2
        }
        // 要确定有多少行
        // 9  --> 8 --> 2 --> 3
        // 6  --> 5 --> 1 --> 2
        let row = (count - 1) / 3 + 1
        
        // 通过列数、行数与每一列的宽高计算大小
        let width = CGFloat(col) * itemWH + CGFloat(col - 1) * itemMargin
        let height = CGFloat(row) * itemWH + CGFloat(row - 1) * itemMargin
        
        let size = CGSize(width: width, height: height)
        return size
    }

}
