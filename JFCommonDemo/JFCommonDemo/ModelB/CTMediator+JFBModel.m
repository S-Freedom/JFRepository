//
//  CTMediator+JFBModel.m
//  JFCommonDemo
//
//  Created by 黄鹏飞 on 2019/5/27.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "CTMediator+JFBModel.h"

NSString *const kModelBName = @"JFBModel";
NSString *const kActionBName = @"JFBModelDetailViewController";
NSString *const kActionPush2BName = @"push2BWithParams";

@implementation CTMediator (JFBModel)


- (JFBModelViewController *)push2BDetailWithParams:(NSDictionary *)params{
    
    JFBModelViewController *aModelVC = [self performTarget:kModelBName action:kActionBName params:params shouldCacheTarget:YES];
    return aModelVC;
}

- (JFBModelViewController *)push2BWithParams:(NSDictionary *)params callback:(MyBlock)block{
    
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:params];
    mDic[@"block"] = block;
    return [self performTarget:kModelBName action:kActionPush2BName params:mDic shouldCacheTarget:YES];;
}
@end
