//
//  DemoUtil.h
//  AAIClientDemo
//
//  Created by 贾立飞 on 2017/2/17.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoUtil : NSObject

+ (NSString *)hmacsha1:(NSString *)data secret:(NSString *)key;

// 过滤标点
+ (NSString *)filterIllegalChar:(NSString *)str;

// 汉子转拼音
+ (NSString *)convertHZ2PY:(NSString *)string;
@end
