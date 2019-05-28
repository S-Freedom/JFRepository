//
//  CTMediator+JFCModel.m
//  JFCommonDemo
//
//  Created by 黄鹏飞 on 2019/5/27.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "CTMediator+JFCModel.h"

@implementation CTMediator (JFCModel)

NSString *const kModelCName = @"JFCModel";
NSString *const kActionCName = @"JFCModelDetailViewController";


- (JFCModelViewController *)push2CDetailWithParams:(NSDictionary *)params{
    
    JFCModelViewController *aModelVC = [self performTarget:kModelCName action:kActionCName params:params shouldCacheTarget:YES];
    return aModelVC;
}
@end
