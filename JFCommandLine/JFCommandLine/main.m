//
//  main.m
//  JFCommandLine
//
//  Created by 黄鹏飞 on 2019/1/28.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

/**
 *  1. NSObject 占用8个字节
 *  2. Person包含两个对象name ,age 占用24个字节 = 8*3
 *  3. Student 继承Person ，Student没有对象，则占用24个字节
 *  4. Student包含两个对象name1, age1, 占用40个字节 8+8*4
 *  5. Student 只包含Person对象，则占用16个字节 8+8
 *
 */

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        int age = 10;
//        void (^block)(void) = ^{
//            NSLog(@"%d", age);
//        };
//        block();

        
        
    }
    return 0;
}
