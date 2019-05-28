//
//  JFBModelViewController.m
//  JFCommonDemo
//
//  Created by 黄鹏飞 on 2019/5/27.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "JFBModelViewController.h"

@interface JFBModelViewController ()

@end

@implementation JFBModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%s", __func__);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    label.text = @"JFBModelViewController";
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
    if(self.myBlock){
        self.myBlock(@"this is b block callBack.");
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
