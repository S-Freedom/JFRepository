//
//  SecViewController.m
//  JFTest
//
//  Created by 黄鹏飞 on 2019/1/29.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "SecViewController.h"
#import "JFGetController.h"
@interface SecViewController ()

@end

@implementation SecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"SecViewController  %@", [JFGetController getCurrentVC]);
    NSLog(@"SecViewController  %@", [JFGetController topViewController]);
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
