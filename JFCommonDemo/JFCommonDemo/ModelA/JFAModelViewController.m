//
//  JFAModelViewController.m
//  JFCommonDemo
//
//  Created by 黄鹏飞 on 2019/5/27.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "JFAModelViewController.h"
#import "JFBModelViewController.h"
#import "CTMediator+JFBModel.h"
@interface JFAModelViewController ()

@end

@implementation JFAModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%s", __func__);
    NSLog(@"classroomId : %@", self.classroomId);

    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    label.text = @"JFAModelViewController";
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSDictionary *params = @{
                             @"classroomId" : @"1001",
                             @"lessonId" : @"1002"
                             };
    // 1: 传递参数，返回控制器
//    JFBModelViewController *bVC = [[CTMediator sharedInstance] push2BDetailWithParams:params];
    
    // 2.传递参数，返回控制器，回调一个字符串
    JFBModelViewController *bVC = [[CTMediator sharedInstance] push2BWithParams:params callback:^(NSString * _Nonnull text) {
        NSLog(@"%@", text);
    }];
    [self.navigationController pushViewController:bVC animated:YES];
}


@end
