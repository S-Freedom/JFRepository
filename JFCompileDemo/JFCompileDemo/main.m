//
//  main.m
//  JFCompileDemo
//
//  Created by 黄鹏飞 on 2019/4/2.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFPerson.h"
#import "JFStudent.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        JFStudent *stu = [[JFStudent alloc] init];
        
        [stu say:@"jack"];
        objc_msgSend();
        NSLog(@"Hello ");
//        [stu test:@"jack" age:20];
    }
    return 0;
}
