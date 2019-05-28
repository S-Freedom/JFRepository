//
//  CTMediator+JFAModel.m
//  JFCommonDemo
//
//  Created by 黄鹏飞 on 2019/5/27.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "CTMediator+JFAModel.h"

NSString *const kModelAName = @"JFAModel";
NSString *const kActionAName = @"goDetailViewController";

@implementation CTMediator (JFAModel)

- (JFAModelViewController *)push2DetailWithParams:(NSDictionary *)params{
    
    JFAModelViewController *aModelVC = [self performTarget:kModelAName action:kActionAName params:params shouldCacheTarget:YES];
    return aModelVC;
}
@end
