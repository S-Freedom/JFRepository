//
//  JFHomeViewController.swift
//  JFSwitftStudy
//
//  Created by 黄鹏飞 on 2019/5/31.
//  Copyright © 2019 com.hpf. All rights reserved.
//

import UIKit

class JFHomeViewController: JFBaseViewController , UICollectionViewDelegate, UICollectionViewDataSource {
    
    let homeCellId : String = "homeCellId"
    var dataArray : [Any] = Array();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        collectionView.register(JFHomeCell.layerClass, forCellWithReuseIdentifier: homeCellId)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView .dequeueReusableCell(withReuseIdentifier: homeCellId, for: indexPath)
        
        return cell
    }
    
    lazy var flowLayout : UICollectionViewFlowLayout = {
        
        var flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        return flowLayout
    }()
    
    lazy var collectionView : UICollectionView = {
        
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    } ()
}
