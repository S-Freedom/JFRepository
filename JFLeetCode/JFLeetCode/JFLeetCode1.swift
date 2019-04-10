//
//  JFSolution.swift
//  JFLeetCode
//
//  Created by 黄鹏飞 on 2019/4/10.
//  Copyright © 2019 com.hpf. All rights reserved.
//

import Cocoa

class JFLeetCode1: NSObject {

    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        
        for i in 0..<nums.count {
            for j in 0..<nums.count{
                if(nums[i] == target - nums[j]){
                    return [i,j]
                }
            }
        }
        return []
    }
    
    func twoSum1(_ nums: [Int], _ target: Int) -> [Int] {
        
        var dic : [Int: Int] =  [Int: Int]()
        for i in 0..<nums.count {
            dic[nums[i]] = i
        }
        
        for i in 0..<nums.count {
            
            let temp: Int = target - nums[i]
            // 字典内包含target - nums[i], 并且可以获取到值
            // 并且 两个索引不一致, 防止有[3,3],6 这种情况
            if dic.keys.contains(temp) && (dic[temp] != nil && i != dic[temp]) {

                return [i, dic[temp]!]
            }
        }
        return []
    }
    
    func twoSum2(_ nums: [Int], _ target: Int) -> [Int] {
        var dict = [Int:Int]() //为了方便得到序列号，使用字典
        
        for (i, num) in nums.enumerated() {
            if let lastIndex = dict[target - num] {
                return [lastIndex, i]
            }else {
                dict[num] = i
                /*
                 dict[2] = 0
                 */
            }
        }
        return []
    }
}
