//
//  SuViewController.m
//  JFTest
//
//  Created by 黄鹏飞 on 2019/1/29.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "SuViewController.h"
#import "JFGetController.h"
#import "FirstViewController.h"
#import "SecViewController.h"
@interface SuViewController ()

@end

@implementation SuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"SuViewController  %@", [JFGetController getCurrentVC]);
    NSLog(@"SuViewController  %@", [JFGetController topViewController]);
    
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    SecViewController *secVC = [[SecViewController alloc] init];
    [self addChildViewController:firstVC];
    [self addChildViewController:secVC];
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
