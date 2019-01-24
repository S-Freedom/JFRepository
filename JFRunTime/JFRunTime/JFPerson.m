//
//  JFPerson.m
//  JFRunTime
//
//  Created by 黄鹏飞 on 2019/1/23.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "JFPerson.h"


@implementation JFPerson

- (void)eat{
    
    NSLog(@"%s", __func__);
}

- (void)run:(CGFloat)speed{
    
    NSLog(@"%s", __func__);
}

- (BOOL)isWalking{
    
    NSLog(@"%s", __func__);
    return YES;
}

- (BOOL)isWalkingForSpeed:(CGFloat)speed{
    
    NSLog(@"%s", __func__);
    return YES;
}

- (NSString *)getFirstName{
    
    NSLog(@"%s", __func__);
    return @"getFirstName";
}

+ (NSString *)getClassName{
    
    NSLog(@"%s", __func__);
    return @"getClassName";
}

+ (void)getClassInfo{
    
    NSLog(@"%s", __func__);
}

@end

@interface JFStudent()
{
    int stuHobby;
    NSString *stuInfo;
}
// 所在年级
@property (nonatomic, assign) NSInteger classLevel;
@end

@implementation JFStudent

- (void)privateStudentMtd{
    NSLog(@"%s", __func__);
}
- (void)studyWithName:(NSString *)sName{
    NSLog(@"%s", __func__);
}

@end

@implementation JFClassRoom

- (NSInteger)stuCount{
    
    NSLog(@"%s", __func__);
    return 1;
}

- (NSString *)stuNames{
    
    NSLog(@"%s", __func__);
    return @"stuNames";
}

+ (void)study{
    
    NSLog(@"%s", __func__);
}
@end
