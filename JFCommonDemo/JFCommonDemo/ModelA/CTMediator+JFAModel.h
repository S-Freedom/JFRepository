//
//  CTMediator+JFAModel.h
//  JFCommonDemo
//
//  Created by 黄鹏飞 on 2019/5/27.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "CTMediator.h"
#import "JFAModelViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (JFAModel)

- (JFAModelViewController *)push2DetailWithParams:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
