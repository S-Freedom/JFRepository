//
//  JFCModelViewController.m
//  JFCommonDemo
//
//  Created by 黄鹏飞 on 2019/5/27.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "JFCModelViewController.h"

@interface JFCModelViewController ()

@end

@implementation JFCModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%s", __func__);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    label.text = @"JFCModelViewController";
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
