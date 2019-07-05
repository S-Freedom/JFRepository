//
//  JFCollectionViewItem.swift
//  JFMacDemo
//
//  Created by 黄鹏飞 on 2019/6/18.
//  Copyright © 2019 com.hpf. All rights reserved.
//

import Cocoa

class JFCollectionViewItem: NSCollectionViewItem {

    @IBOutlet weak var goJumpbtn: NSButton!
    @IBOutlet weak var text: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer?.backgroundColor = NSColor.yellow.cgColor
    }
    
    @IBAction func btnClick(_ sender: NSButton) {
        print("click btn")
    }
}
