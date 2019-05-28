//
//  Target_JFAModel.m
//  JFCommonDemo
//
//  Created by 黄鹏飞 on 2019/5/27.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "Target_JFAModel.h"

@implementation Target_JFAModel

- (UIViewController *)Action_goDetailViewController:(NSDictionary *)params{
    
    JFAModelViewController *vc = [[JFAModelViewController alloc] init];
    vc.classroomId = params[@"classroomId"];
    return vc;
}
@end
