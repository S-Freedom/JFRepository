//
//  ViewController.swift
//  JFMacDemo
//
//  Created by 黄鹏飞 on 2019/6/17.
//  Copyright © 2019 com.hpf. All rights reserved.
//

import Cocoa

class CollectionViewController: NSViewController ,NSCollectionViewDataSource, NSCollectionViewDelegate {
    
    var textField = NSTextField()
    var dataArray = [Int]()
    
    let cellId = "CellID"
    
    @IBOutlet weak var collectionView: NSCollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let item : JFCollectionViewItem = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "cellId"), for: indexPath) as! JFCollectionViewItem
        item.text.stringValue = "item \(indexPath.item)"
        return item
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        print("click item")
    }
    
    func loadColletionView(){
        
        collectionView.register(JFCollectionViewItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "cellId"))
        dataArray = [1,2,3,4,5]
    }
    
    func createUI() {
        
        let btn = NSButton(title: "Tips", target: self, action: #selector(btnClick))
        btn.frame = NSRect(x: 100, y: 100, width: 100, height: 40)
        btn.title = "Tips";
        btn.bezelColor = NSColor.black
        btn.setButtonType(NSButton.ButtonType.momentaryPushIn)
        view.addSubview(btn)
        
        textField = NSTextField()
        textField.placeholderString = "我是占位符......"
        textField.isEditable = true
        textField.isBordered = false
        //        textField.backgroundColor = NSColor.green
        textField.textColor = NSColor.black
        textField.alignment = NSTextAlignment.center
        textField.maximumNumberOfLines = 2
        textField.frame = NSRect(x: 100, y: 150, width: 200, height: 40)
        //        textField.stringValue = "我是测试文字，我是测试文字，我是测试文字，我是测试文字，我是测试文字，我是测试文字，我是测试文字"
        view.addSubview(textField)
    }
    @objc func btnClick(){
        
        print("click me!")
    }
}

