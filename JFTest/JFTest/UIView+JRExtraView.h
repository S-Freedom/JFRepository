//
//  UIView+JRExtraView.h
//  JFTest
//
//  Created by 黄鹏飞 on 2019/2/20.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


IB_DESIGNABLE
/** View的XIB可视化扩展类> */
@interface UIView (JRExtraView)

/*
 * 给UIView 设置圆角
 */
@property (assign,nonatomic) IBInspectable NSInteger cornerRadius;
@property (assign,nonatomic) IBInspectable BOOL  masksToBounds;

/*
 * borderColor 设置边框颜色
 * borderWidth 设置边框宽度
 */
@property (assign,nonatomic) IBInspectable NSInteger borderWidth;
@property (strong,nonatomic) IBInspectable UIColor   *borderColor;

@end

NS_ASSUME_NONNULL_END
