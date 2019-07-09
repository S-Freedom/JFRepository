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

#import <UserNotifications/UserNotifications.h>
@interface ViewController ()

@property (nonatomic, strong) UIButton *goABtn;
@property (nonatomic, strong) UIButton *goBBtn;
@property (nonatomic, strong) UIButton *goCBtn;
@end

@implementation ViewController

- (NSString*)disable_EmojiString:(NSString *)text
{
    //去除表情规则
    //  \u0020-\\u007E  标点符号，大小写字母，数字
    //  \u00A0-\\u00BE  特殊标点  (¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾)
    //  \u2E80-\\uA4CF  繁简中文,日文，韩文 彝族文字
    //  \uF900-\\uFAFF  部分汉字
    //  \uFE30-\\uFE4F  特殊标点(︴︵︶︷︸︹)
    //  \uFF00-\\uFFEF  日文  (ｵｶｷｸｹｺｻ)
    //  \u2000-\\u201f  特殊字符(‐‑‒–—―‖‗‘’‚‛“”„‟)
    // 注：对照表 http://blog.csdn.net/hherima/article/details/9045765
    
    NSRegularExpression* expression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    
    NSString* result = [expression stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0, text.length) withTemplate:@""];
    
    return result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s", __func__);
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSString *str = [self disable_EmojiString:@"sdfsdf😯😯谦与谦逊🎭kldg"];
    NSLog(@"str : %@", str);
    
//    self.goABtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 50)];
//    [self.goABtn setTitle:@"goAModel" forState:UIControlStateNormal];
//    [self.goABtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.goABtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    self.goABtn.tag = 1;
//    [self.view addSubview:self.goABtn];
//
//    self.goBBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
//    [self.goBBtn setTitle:@"goBModel" forState:UIControlStateNormal];
//    [self.goBBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.goBBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    self.goBBtn.tag = 2;
//    [self.view addSubview:self.goBBtn];
//
//    self.goCBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 100, 100, 50)];
//    [self.goCBtn setTitle:@"goCModel" forState:UIControlStateNormal];
//    [self.goCBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.goCBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    self.goCBtn.tag = 3;
//    [self.view addSubview:self.goCBtn];
    
    
    
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"titletitletitle";
    content.body = @"bodybodybody";
    content.sound = [UNNotificationSound defaultSound];
    
    // 在 设定时间 后推送本地推送
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                                                  triggerWithTimeInterval:5 repeats:NO];
    
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"FiveSecond"
                                                                          content:content trigger:trigger];
    
    //添加推送成功后的处理！
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
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
