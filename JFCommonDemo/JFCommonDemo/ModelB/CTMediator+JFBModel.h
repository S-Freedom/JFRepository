//
//  CTMediator+JFBModel.h
//  JFCommonDemo
//
//  Created by 黄鹏飞 on 2019/5/27.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "CTMediator.h"
#import "JFBModelViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (JFBModel)

- (JFBModelViewController *)push2BWithParams:(NSDictionary *)params callback:(MyBlock)block;
- (JFBModelViewController *)push2BDetailWithParams:(NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END
