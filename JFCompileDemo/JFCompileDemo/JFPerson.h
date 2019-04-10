//
//  JFPerson.h
//  JFCompileDemo
//
//  Created by 黄鹏飞 on 2019/4/2.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFPerson : NSObject

- (void)say:(NSString *)name;

- (void)test1;
- (void)test:(NSString *)name age:(int)age;
@end

NS_ASSUME_NONNULL_END
