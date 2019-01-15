//
//  JFModel.h
//  JFTanDemo
//
//  Created by 黄鹏飞 on 2018/12/28.
//  Copyright © 2018 com.hpf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFModel : NSObject<NSSecureCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger age;

@end

NS_ASSUME_NONNULL_END
