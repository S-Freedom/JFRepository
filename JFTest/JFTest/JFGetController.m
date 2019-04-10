//
//  JFGetController.m
//
//
//  Created by huangpengfei on 2017/6/27.
//
//

#import "JFGetController.h"

#define Alpha_dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define Alpha_dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

@implementation JFGetController

#pragma mark - 获取跟控制器
+ (UIViewController *)getRootViewController
{
    __block UIViewController *rootVC;
    Alpha_dispatch_main_sync_safe(^{
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        id rootViewController = window.rootViewController;
        if ([rootViewController isKindOfClass:[UIViewController class]]) {
            rootVC = rootViewController;
        }
    });

    return rootVC;
}

#pragma mark - 获取顶层VC
+ (UIViewController *)topViewController {
    __block UIViewController *resultVC;
    Alpha_dispatch_main_sync_safe(^{
        resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
        while (resultVC.presentedViewController) {
            resultVC = [self _topViewController:resultVC.presentedViewController];
        }
    });
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

#pragma mark - 获取当前显示的VC
+ (UIViewController *)getCurrentVC
{
    UIViewController *resultVC;
    resultVC = [self jf_topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self jf_topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)jf_topViewController:(UIViewController *)vc
{
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

+ (UIViewController *)topViewController:(UIViewController *)vc {
    
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

#pragma mark -  获取当前导航控制器
+ (UINavigationController *)currentNC
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    if (![[UIApplication sharedApplication].windows.lastObject isKindOfClass:[UIWindow class]]) {
        NSAssert(0, @"未获取到导航控制器");
        return nil;
    }
    UIViewController *rootViewController = keyWindow.rootViewController;
    return [self getCurrentNCFrom:rootViewController];
}

+ (UINavigationController *)getCurrentNCFrom:(UIViewController *)vc
{
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UINavigationController *nc = ((UITabBarController *)vc).selectedViewController;
        return [self getCurrentNCFrom:nc];
    }
    else if ([vc isKindOfClass:[UINavigationController class]]) {
        if (((UINavigationController *)vc).presentedViewController) {
            return [self getCurrentNCFrom:((UINavigationController *)vc).presentedViewController];
        }
        return [self getCurrentNCFrom:((UINavigationController *)vc).topViewController];
    }
    else if ([vc isKindOfClass:[UIViewController class]]) {
        if (vc.presentedViewController) {
            return [self getCurrentNCFrom:vc.presentedViewController];
        }
        else {
            return vc.navigationController;
        }
    }
    else {
        NSAssert(0, @"未获取到导航控制器");
        return nil;
    }
}

@end
