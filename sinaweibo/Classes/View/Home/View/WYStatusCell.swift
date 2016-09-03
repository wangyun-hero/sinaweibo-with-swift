//
//  WYStatusCell.swift
//  sinaweibo
//
//  Created by 王云 on 16/9/3.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

class WYStatusCell: UITableViewCell {

//    var status : WYStatus? {
//        didSet{
//            nameLabel.text = status?.text
//        }
//        
//    }
    
    var statusViewmodel : WYStatusViewModel? {
        didSet {
            nameLabel.text = statusViewmodel?.status?.text
            
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //重写构造方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    func setupUI () {
        //添加控件
       contentView.addSubview(nameLabel)
        //添加约束
        nameLabel.snp_makeConstraints { (make ) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(10)
        }
    }
    
    //懒加载nameLabel
    lazy var nameLabel :UILabel = {
        
        let nameLabel = UILabel(textColour: UIColor.darkGray, fontSize: 14)
        
        return nameLabel
    }()

    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
