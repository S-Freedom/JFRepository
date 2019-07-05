//
//  JFSong.swift
//  JFMacDemo
//
//  Created by 黄鹏飞 on 2019/6/24.
//  Copyright © 2019 com.hpf. All rights reserved.
//

import Cocoa

class JFSong: NSObject {

    var name : String?
    var url : String?
    var downCount : Int?
    
    override init() {
        
        super.init()
        
        name = "song"
        url = "https://baidu.com"
        downCount = 10000
    }
}
