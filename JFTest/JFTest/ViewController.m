//
//  ViewController.m
//  JFTest
//
//  Created by 黄鹏飞 on 2019/1/28.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "ViewController.h"
//#import "JFPerson.h"
//#import "NSObject+Test.h"
//#import "SuViewController.h"
//#import "FirstViewController.h"
//#import "SecViewController.h"
//#import "JFGetController.h"
@interface ViewController ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) long cha;     // 过期时间和创建时间的差值
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [JFPerson test];
//    [NSObject test];
    
//    SuViewController *su = [[SuViewController alloc] init];
//    FirstViewController *firstVC = [[FirstViewController alloc] init];
//    SecViewController *secVC = [[SecViewController alloc] init];
//    [su addChildViewController:firstVC];
//    [su addChildViewController:secVC];
//
//    NSLog(@"ViewController  %@", [JFGetController getCurrentVC]);
//    NSLog(@"ViewController  %@", [JFGetController topViewController]);

    
    
//    char c[] = "diﬃculty target";
//
//    for(NSUInteger i =0; i< strlen(c); i ++){
//        NSLog(@"%c", c[i]);
//    }
    
//    self.cha = 10;
//    [self.timer fire];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

}
- (void)cacuTime{
    
    if(self.cha > 0){
        
        self.cha --;
        NSString *timeStr = [self convertFromSecond:self.cha];
        NSLog(@"%@", timeStr);
    }else{
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (NSTimer *)timer{
    if(!_timer){
        
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(cacuTime) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (NSString *)convertFromSecond:(long)sec{
    
    NSMutableString *mStr = [NSMutableString string];
    
    long tempSec = sec;
    NSInteger hour = 0;
    NSInteger minute = 0;
    if(tempSec >= 3600){
        hour = tempSec / 3600;
        [mStr appendString:[NSString stringWithFormat:@"%02li小时", (long)hour]];
        tempSec = sec - hour * 3600;
    }
    
    if(tempSec >= 60 || hour > 0){
        minute = tempSec / 60;
        [mStr appendString:[NSString stringWithFormat:@"%02li分", minute]];
        tempSec = tempSec - minute * 60;
    }
    
    if(tempSec > 0 || minute > 0 || hour > 0){
        
        [mStr appendString:[NSString stringWithFormat:@"%02li秒", tempSec]];
    }
    return [mStr copy];
}

- (void)test{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        queue.suspended = YES;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:3];
            NSLog(@"1");
            queue.suspended = NO;
        });
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        
        queue.suspended = YES;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2");
            queue.suspended = NO;
        });
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        
        queue.suspended = YES;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"3");
            queue.suspended = NO;
        });
    }];
    
    [op2 addDependency:op1];
    [op3 addDependency:op2];
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    
    [queue setMaxConcurrentOperationCount:1];
}

@end
