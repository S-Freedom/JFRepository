//
//  JFLeetCode344.swift
//  JFLeetCode
//
//  Created by 黄鹏飞 on 2019/4/11.
//  Copyright © 2019 com.hpf. All rights reserved.
//

import Cocoa

class JFLeetCode344: NSObject {

    // 反转字符串，method1: 首尾交换
    func reverseString(_ s: inout [Character]) {
        
        var i = 0
        var j = s.count - 1
        var cs = s
        while i<j {
            
            let temp = cs[i]
            cs[i] = cs[j]
            cs[j] = temp
            i+=1
            j-=1
        }
        print(cs)
    }
    
    func reverseString2(_ s: inout [Character]){
        
        var cs : [Character] = []
        for i in (0..<s.count).reversed() {
            cs.append(s[i])
        }
    }
}
