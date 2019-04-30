//
//  JFLeetCode3.swift
//  JFLeetCode
//
//  Created by 黄鹏飞 on 2019/4/11.
//  Copyright © 2019 com.hpf. All rights reserved.
//

import Cocoa

class JFLeetCode3: NSObject {

    func lengthOfLongestSubstring(_ s: String) -> Int {
        
        // 将字符串转换成字符数组
        let c : [Character] = Array(s)
        var set : Set = Set<Character>()
        
        let n = s.count
        var maxIndex = 0
        var i : Int = 0 // 记录首个重复的字母
        var j : Int = 0 // 记录最后一个字母
        while i<n && j<n {
            
            if set.contains(c[j]){
                set.remove(c[i])
                i+=1
            }else{
                set.insert(c[j])
                j+=1
                maxIndex  = max(maxIndex, j - i)
            }
        }
        return maxIndex;
    }
}
