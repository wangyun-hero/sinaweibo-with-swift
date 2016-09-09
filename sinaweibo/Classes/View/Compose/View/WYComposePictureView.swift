//
//  WYComposePictureView.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/9.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYComposePictureView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI () {
        //注册cell
        self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        //设置数据源
        self.dataSource = self
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
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = RandomColor
        return cell
    }
    
    
    
}
