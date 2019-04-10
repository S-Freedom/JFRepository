//
//  JFGetController.h
//
//
//  Created by huangpengfei on 2017/6/27.
//  
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JFGetController : NSObject
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

/**
 *
 *  获取顶层VC
 *
 */
+ (UIViewController *)topViewController;

/**
 *
 *  获取当前显示的VC
 *
 */
+ (UIViewController *)getCurrentVC;

/**
 *
 *  获取当前导航控制器
 *
 */
+ (UINavigationController *)currentNC;


@end
