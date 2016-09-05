//
//  WYStatusPictureView.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/4.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

let itemMargin: CGFloat = 5
// 确定每一个条目的宽高
let itemWH = (HMScreenW - 2 * HMStatusCellMargin - 2 * itemMargin) / 3

class WYStatusPictureView: UICollectionView {

    //ID
    let WYPictureViewCell = "cell"
    
    var pic_urls: [WYStatusPictureInfo]? {
        
        didSet {
            self.snp_updateConstraints { (make ) in
                make.size.equalTo(calcSize(count: pic_urls?.count ?? 0))
            }
            //刷新数据
            self.reloadData()
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
//        backgroundColor = UIColor.red
        //注册cell
        self.register(WYPicturViewCell.self, forCellWithReuseIdentifier: WYPictureViewCell)
        //创建流水布局
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        // 自己成为自己的数据源
        self.dataSource = self
        //cell的大小
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        //间距
        layout.minimumLineSpacing = itemMargin
        layout.minimumInteritemSpacing = itemMargin
    }
    

    private func calcSize(count: Int) -> CGSize {
        
        if count == 1 {
            //取到图片的大小
            if let size = pic_urls?.first?.size {
                // 通过屏幕比例计算出真实的大小
                let scale = UIScreen.main.scale
                let result = CGSize(width: scale * size.width, height: scale * size.height)
                
                // 调用itemSize的大小
                // 1. 取到layout
                let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
                layout.itemSize = result
                
                // 2. 调整配图控件的大大小
                return result
            }
            
        }
        
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
        
        // 如果是多张图片，要调条目的大小调整回来
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        // 调条目大小调整成正方形
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        
        return size
    }

}

extension WYStatusPictureView : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pic_urls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WYPictureViewCell, for: indexPath) as! WYPicturViewCell
        //取到对应位置的模型
        let model = pic_urls![indexPath.item]
        //设置数据
        cell.pictureInfo = model
        
        return cell
    }
    
}


    
    
    
    
    

