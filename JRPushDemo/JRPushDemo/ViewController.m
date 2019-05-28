//
//  ViewController.m
//  JRPushDemo
//
//  Created by 黄鹏飞 on 2019/5/20.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "ViewController.h"
#import <JRFileManager.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *dataStr = [JRFileManager getCurrentDataString];
    NSLog(@"dataStr %@", dataStr);
}


@end
