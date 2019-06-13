//
//  ViewController.m
//  JFFFmpegDemo
//
//  Created by 黄鹏飞 on 2019/6/13.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "ViewController.h"
#import "FFTest.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [FFTest ffmpegTestConfig];
    NSString *fileStr = [[NSBundle mainBundle] pathForResource:@"Test.mov" ofType:nil];
    [FFTest ffmpegVideoOpenfile:fileStr];
}


@end
