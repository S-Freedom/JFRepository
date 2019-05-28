////
////  AppDelegate.m
////  JRPushDemo
////
////  Created by 黄鹏飞 on 2019/5/20.
////  Copyright © 2019 com.hpf. All rights reserved.
////
//
//#define JRAppId @"d007401351c45"
//#define JRAPPKEY @"IT6T6SH87A7X"
//
//#import "AppDelegate.h"
//
//#import "XGPush.h"
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
//#import <UserNotifications/UserNotifications.h>
//#endif
//@interface AppDelegate ()<XGPushDelegate>
//
//@end
//
//@implementation AppDelegate
//
//#pragma mark - XGPushDelegate
//- (void)xgPushDidFinishStart:(BOOL)isSuccess error:(NSError *)error {
//    NSLog(@"%s, result %@, error %@", __FUNCTION__, isSuccess?@"OK":@"NO", error);
////    UIViewController *ctr = [self.window rootViewController];
////    if ([ctr isKindOfClass:[UINavigationController class]]) {
////        ViewController *viewCtr = (ViewController *)[(UINavigationController *)ctr topViewController];
////        [viewCtr updateNotification:[NSString stringWithFormat:@"%@%@", NSLocalizedString(@"register_app", nil), (isSuccess?NSLocalizedString(@"success", nil):NSLocalizedString(@"failed", nil))]];
////    }
//}
//
//- (void)xgPushDidFinishStop:(BOOL)isSuccess error:(NSError *)error {
////    UIViewController *ctr = [self.window rootViewController];
////    if ([ctr isKindOfClass:[UINavigationController class]]) {
////        ViewController *viewCtr = (ViewController *)[(UINavigationController *)ctr topViewController];
////        [viewCtr updateNotification:[NSString stringWithFormat:@"%@%@", NSLocalizedString(@"unregister_app", nil), (isSuccess?NSLocalizedString(@"success", nil):NSLocalizedString(@"failed", nil))]];
////    }
//
//}
//
//- (void)xgPushDidRegisteredDeviceToken:(NSString *)deviceToken error:(NSError *)error {
//    NSLog(@"%s, result %@, error %@", __FUNCTION__, error?@"NO":@"OK", error);
//}
//
//// iOS 10 新增 API
//// iOS 10 会走新 API, iOS 10 以前会走到老 API
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
//// App 用户点击通知
//// App 用户选择通知中的行为
//// App 用户在通知中心清除消息
//// 无论本地推送还是远程推送都会走这个回调
//- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
//    NSLog(@"[XGDemo] click notification");
////    <UNNotificationResponse: 0x2812fd380; actionIdentifier: com.apple.UNNotificationDefaultActionIdentifier, notification: <UNNotification: 0x2812fd0e0; date: 2019-05-20 11:43:52 +0000, request: <UNNotificationRequest: 0x281c99890; identifier: 38D83EEE-E0EC-4C6B-BE62-A4053016A422, content: <UNNotificationContent: 0x2827e8a80; title: 您的3年级英语课已经开课, subtitle: 开课提醒, body: 张小斐，你定制的3年级英语课已经开课了，赶快来上课吧，上课链接是xxxxxxxxxxx, 点击进入教室，最后还有30分钟哦, summaryArgument: (null), summaryArgumentCount: 0, categoryIdentifier: , launchImageName: , threadIdentifier: , attachments: (
////    ), badge: (null), sound: <UNNotificationSound: 0x2836f42a0>,, trigger: <UNPushNotificationTrigger: 0x2810f0150; contentAvailable: NO, mutableContent: NO>>>>
//
//
////    <UNNotificationResponse: 0x281d346e0; actionIdentifier: com.apple.UNNotificationDefaultActionIdentifier, notification: <UNNotification: 0x281d34760; date: 2019-05-20 11:59:21 +0000, request: <UNNotificationRequest: 0x281358d50; identifier: 1F29253B-E246-4F32-9625-D14E3B87C5EB, content: <UNNotificationContent: 0x282818480; title: title, subtitle: subtitle, body: content content content , summaryArgument: (null), summaryArgumentCount: 0, categoryIdentifier: , launchImageName: , threadIdentifier: , attachments: (
////    ), badge: (null), sound: <UNNotificationSound: 0x28391c6c0>,, trigger: <UNPushNotificationTrigger: 0x281f04190; contentAvailable: NO, mutableContent: NO>>>>
//
//
////    UNNotificationContent *content = response.notification.request.content;
////    content.title;  // 标题
////    content.subtitle;   // 副标题
////    content.body;   // 正文
////    content.badge;  // 角标
//
////    response.actionIdentifier
////    com.apple.UNNotificationDefaultActionIdentifier
////    com.apple.UNNotificationDismissActionIdentifier
//    NSLog(@"response : %@", response);
//    if ([response.actionIdentifier isEqualToString:@"xgaction001"]) {
//        NSLog(@"click from Action1");
//    } else if ([response.actionIdentifier isEqualToString:@"xgaction002"]) {
//        NSLog(@"click from Action2");
//    }
//
//    [[XGPush defaultManager] reportXGNotificationResponse:response];
//
//    completionHandler();
//}
//
//// App 在前台弹通知需要调用这个接口
//- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
//    NSLog(@"%@", notification);
//    [[XGPush defaultManager] reportXGNotificationInfo:notification.request.content.userInfo];
//    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
//}
//#endif
//
///**
// 统一收到通知消息的回调
// @param notification 消息对象
// @param completionHandler 完成回调
// @note SDK 3.2.0+
// */
//- (void)xgPushDidReceiveRemoteNotification:(id)notification withCompletionHandler:(void (^)(NSUInteger))completionHandler {
//
//    NSLog(@"notification %@", notification);
//    if ([notification isKindOfClass:[NSDictionary class]]) {
//        [[XGPush defaultManager] reportXGNotificationInfo:(NSDictionary *)notification];
//        completionHandler(UIBackgroundFetchResultNewData);
//    } else if ([notification isKindOfClass:[UNNotification class]]) {
//        [[XGPush defaultManager] reportXGNotificationInfo:((UNNotification *)notification).request.content.userInfo];
//        completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
//    }
//}
//
//- (void)xgPushDidSetBadge:(BOOL)isSuccess error:(NSError *)error {
//    NSLog(@"%s, result %@, error %@", __FUNCTION__, error?@"NO":@"OK", error);
//}
//
//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//
//
//    [[XGPush defaultManager] setEnableDebug:YES];
//    XGNotificationAction *action1 = [XGNotificationAction actionWithIdentifier:@"xgaction001" title:@"xgAction1" options:XGNotificationActionOptionNone];
//    XGNotificationAction *action2 = [XGNotificationAction actionWithIdentifier:@"xgaction002" title:@"xgAction2" options:XGNotificationActionOptionDestructive];
//    if (action1 && action2) {
//        XGNotificationCategory *category = [XGNotificationCategory categoryWithIdentifier:@"xgCategory" actions:@[action1, action2] intentIdentifiers:@[] options:XGNotificationCategoryOptionNone];
//
//        XGNotificationConfigure *configure = [XGNotificationConfigure configureNotificationWithCategories:[NSSet setWithObject:category] types:XGUserNotificationTypeAlert|XGUserNotificationTypeBadge|XGUserNotificationTypeSound];
//        if (configure) {
//            [[XGPush defaultManager] setNotificationConfigure:configure];
//        }
//    }
//    //6bb30e9d90871aef3601674551a60fd6b72a4893d1e590456411f855784e5e22
//    uint32_t appId = 2200334450;
//    [[XGPush defaultManager] startXGWithAppID:appId appKey:@"IT6T6SH87A7X" delegate:self];
//    [[XGPush defaultManager] reportXGNotificationInfo:launchOptions];
//
//    NSDictionary *remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//    NSLog(@"remoteNotification : %@", remoteNotification);
//    return YES;
//}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
//    NSLog(@"userInfo %@", userInfo);
//    [[XGPush defaultManager] reportXGNotificationInfo:userInfo];
//    completionHandler(UIBackgroundFetchResultNewData);
//}
//
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    NSLog(@"[JRPushDemo] register APNS fail.\n[XGDemo] reason : %@", error);
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"registerDeviceFailed" object:nil];
//}
//
//- (void)applicationWillResignActive:(UIApplication *)application {
//    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
//    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
//}
//
//
//- (void)applicationDidEnterBackground:(UIApplication *)application {
//    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//}
//
//
//- (void)applicationWillEnterForeground:(UIApplication *)application {
//    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//}
//
//
//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//}
//
//
//- (void)applicationWillTerminate:(UIApplication *)application {
//    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//}
//
//
//@end
