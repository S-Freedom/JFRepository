//
//  JFHomeCell.swift
//  JFSwitftStudy
//
//  Created by 黄鹏飞 on 2019/5/31.
//  Copyright © 2019 com.hpf. All rights reserved.
//

import UIKit
import SnapKit
class JFHomeCell: UICollectionViewCell {
    
    var imgView = UIImageView()
    var titleLable = UILabel()
    var descLabel = UILabel()
    func initUI() {
        
        self.contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.center.equalTo(0)
        }
    }
    
    var homeModel : JFHomeModel{
        
        get{
            return self.homeModel
        }
        set{
            // 设置
            
        }
    }
}
