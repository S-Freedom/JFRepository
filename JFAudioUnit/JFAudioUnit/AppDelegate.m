//
//  AppDelegate.m
//  JFAudioUnit
//
//  Created by 黄鹏飞 on 2018/12/11.
//  Copyright © 2018 com.hpf. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self resignFirstResponder];
    
    // 拔出耳机的时候暂停音频播放
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(routeChange:) name:AVAudioSessionRouteChangeNotification object:nil];
    // 当电话进来后以致于打断了音频播放
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(interrupt:) name:AVAudioSessionInterruptionNotification object:nil];
    
    return YES;
}

- (void)interrupt:(NSNotification *)notification{
    //    AVAudioSessionInterruptionTypeKey：
    //    取值AVAudioSessionInterruptionTypeBegan表示中断开始
    //    取值AVAudioSessionInterruptionTypeEnded表示中断结束
}

- (void)routeChange:(NSNotification *)notification{
    NSDictionary *dic = notification.userInfo;
    int changeReason= [dic[AVAudioSessionRouteChangeReasonKey] intValue];
    //等于AVAudioSessionRouteChangeReasonOldDeviceUnavailable表示旧输出不可用
    if (changeReason==AVAudioSessionRouteChangeReasonOldDeviceUnavailable) {
        AVAudioSessionRouteDescription *routeDescription=dic[AVAudioSessionRouteChangePreviousRouteKey];
        AVAudioSessionPortDescription *portDescription= [routeDescription.outputs firstObject];
        //原设备为耳机则暂停
        if ([portDescription.portType isEqualToString:@"Headphones"]) {
        }
    }
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}


- (void)remoteControlReceivedWithEvent:(UIEvent *)event{
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPlay:
                
                NSLog(@"暂停播放");
                break;
            case UIEventSubtypeRemoteControlPause:
                
                NSLog(@"继续播放");
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                NSLog(@"下一曲");
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                NSLog(@"上一曲");
                break;
            default:
                break;
        }
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
