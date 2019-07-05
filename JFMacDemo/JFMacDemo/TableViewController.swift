//
//  ViewController-tableView.swift
//  JFMacDemo
//
//  Created by 黄鹏飞 on 2019/6/18.
//  Copyright © 2019 com.hpf. All rights reserved.
//

import Cocoa

class TableViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    var scrollView = NSScrollView()
    var tableView = NSTableView()
    var dataArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataArray.append("C语言程序设计")
        dataArray.append("C陷阱与缺陷")
        dataArray.append("C语言深度剖析")
        dataArray.append("C专家编程")
        dataArray.append("C和指针")
        dataArray.append("C++ primer")
        dataArray.append("C++ primer1")
        dataArray.append("C++ primer2")
        dataArray.append("C++ primer3")
        dataArray.append("C++ primer4")
        dataArray.append("C++ primer5")
        dataArray.append("C++ primer6")
        dataArray.append("C++ primer7")
        dataArray.append("C语言程序设计")
        dataArray.append("C陷阱与缺陷")
        dataArray.append("C语言深度剖析")
        dataArray.append("C专家编程")
        dataArray.append("C和指针")
        dataArray.append("C++ primer")
        dataArray.append("C++ primer1")
        dataArray.append("C++ primer2")
        dataArray.append("C++ primer3")
        dataArray.append("C++ primer4")
        dataArray.append("C++ primer5")
        dataArray.append("C++ primer6")
        dataArray.append("C++ primer7")
        dataArray.append("C语言程序设计")
        dataArray.append("C陷阱与缺陷")
        dataArray.append("C语言深度剖析")
        dataArray.append("C专家编程")
        dataArray.append("C和指针")
        dataArray.append("C++ primer")
        dataArray.append("C++ primer1")
        dataArray.append("C++ primer2")
        dataArray.append("C++ primer3")
        dataArray.append("C++ primer4")
        dataArray.append("C++ primer5")
        dataArray.append("C++ primer6")
        dataArray.append("C++ primer7")
        
        
        loadTableView()
    }
    
    func loadTableView(){
        
        scrollView.frame = NSRect(x: 0, y: 0, width: 200, height: 200)
        scrollView.contentView.documentView = tableView
        scrollView.hasVerticalScroller = true
        scrollView.backgroundColor = NSColor.gray
//        view.addSubview(scrollView)
        
        tableView.frame = scrollView.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = NSColor.green
        scrollView.addSubview(tableView)
        view.addSubview(scrollView)
        
        let column1 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "CellID"))
        column1.minWidth = 100
        column1.width = 150
        column1.maxWidth = 190
        column1.title = "title";
        column1.headerToolTip = "tip"
        
        tableView.addTableColumn(column1)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {

        return dataArray[row]
    }
    
//    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
//        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CellID"), owner: self) as! JFTableCellView
//
//        cell.textField?.stringValue = "\(dataArray[row]) \(row)"
//        return cell
//    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        
        return true
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        print("click row: \(tableView.clickedRow)")
        
    }
    
    func tableView(_ tableView: NSTableView, didAdd rowView: NSTableRowView, forRow row: Int) {
        print("didAdd rowView")
    }
    
    func tableView(_ tableView: NSTableView, didRemove rowView: NSTableRowView, forRow row: Int) {
        print("didRemove rowView")
    }
    
    override func touchesBegan(with event: NSEvent) {
        
        print("增加一行")
        dataArray.append("hahahha")
        tableView.reloadData()
    }
}
