//
//  Target_JFBModel.m
//  JFCommonDemo
//
//  Created by 黄鹏飞 on 2019/5/27.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "Target_JFBModel.h"

@implementation Target_JFBModel

- (UIViewController *)Action_push2BWithParams:(NSDictionary *)params{
    
    JFBModelViewController *vc = [[JFBModelViewController alloc] init];
    vc.lessonId = params[@"lessonId"];
    [vc setMyBlock:^(NSString * _Nonnull text) {
        MyBlock myBlock = params[@"block"];
        if(myBlock){
            myBlock(text);
        }
    }];
    return vc;
}
@end
