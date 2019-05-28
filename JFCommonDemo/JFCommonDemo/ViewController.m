//
//  ViewController.m
//  JFCommonDemo
//
//  Created by 黄鹏飞 on 2019/5/27.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "ViewController.h"
//#import <JRFileManager.h>
//#import "JRUploadManager.h"
//#import "JRNetworking.h"
#import "JFAModelViewController.h"
#import "JFBModelViewController.h"
#import "JFCModelViewController.h"
#import "CTMediator+JFAModel.h"
#import "CTMediator+JFBModel.h"
#import "CTMediator+JFCModel.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *goABtn;
@property (nonatomic, strong) UIButton *goBBtn;
@property (nonatomic, strong) UIButton *goCBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s", __func__);
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.goABtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 50)];
    [self.goABtn setTitle:@"goAModel" forState:UIControlStateNormal];
    [self.goABtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.goABtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.goABtn.tag = 1;
    [self.view addSubview:self.goABtn];
    
    self.goBBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    [self.goBBtn setTitle:@"goBModel" forState:UIControlStateNormal];
    [self.goBBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.goBBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.goBBtn.tag = 2;
    [self.view addSubview:self.goBBtn];
    
    self.goCBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 100, 100, 50)];
    [self.goCBtn setTitle:@"goCModel" forState:UIControlStateNormal];
    [self.goCBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.goCBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.goCBtn.tag = 3;
    [self.view addSubview:self.goCBtn];
//    NSLog(@"datastr : %@",[JRFileManager getCurrentDataString]);
//
//    NSMutableArray *arr = [NSMutableArray new];
//    [arr addObject:nil];
//
//    NSDictionary *dic = [NSDictionary dictionary];
//    NSString *key = dic[nil];
//
//    [self testNetwork];
}

- (void)btnClick:(UIButton *)sender{
    
    if(sender.tag == 1){
        
        NSDictionary *params = @{
                                 @"classroomId" : @"1001"
                                 };
        JFAModelViewController *aVC = [[CTMediator sharedInstance] push2DetailWithParams:params];
        [self.navigationController pushViewController:aVC animated:YES];
        
    }else if(sender.tag == 2){
        
        NSDictionary *params = @{
                                 @"classroomId" : @"1001"
                                 };
        JFBModelViewController *aVC = [[CTMediator sharedInstance] push2BDetailWithParams:params];
        [self.navigationController pushViewController:aVC animated:YES];
        
    }else if(sender.tag == 3){
        
        NSDictionary *params = @{
                                 @"classroomId" : @"1001"
                                 };
        JFCModelViewController *aVC = [[CTMediator sharedInstance] push2CDetailWithParams:params];
        [self.navigationController pushViewController:aVC animated:YES];
        
    }
}

//- (void)testNetwork{
//
//    NSString *urlString = @"https://www.juren.cn/api/v1/homepage/mobilelist";
//
//    NSString *mouduleCode = @"homePageBanner";
//    NSDictionary *parameters = @{
//                                 @"module_code":mouduleCode,
//                                 @"terminal":@"2"   // APP:2
//                                 };
//    [JRNetworkingSingleton POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//
//        NSLog(@"%@", responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"error %@", error.userInfo);
//    }];
//}
@end
