//
//  JFBModelViewController.h
//  JFCommonDemo
//
//  Created by 黄鹏飞 on 2019/5/27.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFBModelViewController : UIViewController

typedef void (^MyBlock)(NSString *text);
@property (nonatomic, copy) MyBlock myBlock;
@property (nonatomic, copy) NSString *lessonId;
@end

NS_ASSUME_NONNULL_END
