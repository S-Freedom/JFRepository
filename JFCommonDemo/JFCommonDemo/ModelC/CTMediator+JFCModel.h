//
//  CTMediator+JFCModel.h
//  JFCommonDemo
//
//  Created by 黄鹏飞 on 2019/5/27.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "CTMediator.h"
#import "JFCModelViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (JFCModel)

- (JFCModelViewController *)push2CDetailWithParams:(NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END
