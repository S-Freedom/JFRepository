//
//  FirstViewController.m
//  JFTest
//
//  Created by 黄鹏飞 on 2019/1/29.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "FirstViewController.h"
#import "JFGetController.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"FirstViewController  %@", [JFGetController getCurrentVC]);
    NSLog(@"FirstViewController  %@", [JFGetController topViewController]);
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
