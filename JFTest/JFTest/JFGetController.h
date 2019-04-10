//
//  JFGetController.h
//
//
//  Created by huangpengfei on 2017/6/27.
//  
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JRLeaningCenterViewController;

@interface JFGetController : NSObject

/**
 *
 *  获取跟控制器
 *
 */
+ (UIViewController *)getRootViewController;

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
