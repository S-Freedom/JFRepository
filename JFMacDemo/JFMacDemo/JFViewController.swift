//
//  JFArrayController.swift
//  JFMacDemo
//
//  Created by 黄鹏飞 on 2019/6/24.
//  Copyright © 2019 com.hpf. All rights reserved.
//

import Cocoa

class JFViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    var songArr = [JFSong]()
    
    @IBOutlet var arrController: NSArrayController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let option = [NSBindingOption.allowsEditingMultipleValuesSelection:true]
        arrController.bind(NSBindingName(rawValue: "contentArray"), to: self, withKeyPath: "songArr", options: option)
        
        songArr.append(JFSong())
        songArr.append(JFSong())
        songArr.append(JFSong())
    }
    
//    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
//
//        return dataArray[row]
//    }
//
//    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
//        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CellID"), owner: self) as! JFTableCellView
//
//        cell.textField?.stringValue = "\(dataArray[row]) \(row)"
//        return cell
//    }
//
//    func numberOfRows(in tableView: NSTableView) -> Int {
//        return dataArray.count
//    }
}
