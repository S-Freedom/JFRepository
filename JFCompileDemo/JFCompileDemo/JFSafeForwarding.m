//
//  JFSafeForwarding.m
//  JFCompileDemo
//
//  Created by 黄鹏飞 on 2019/4/3.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "JFSafeForwarding.h"

@implementation JFSafeForwarding

- (void)test:(NSString *)name age:(int)age{
    
    NSLog(@"%s  name: %@  age:%d ", __func__, name, age);
}
@end
