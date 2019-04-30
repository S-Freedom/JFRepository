//
//  JFCustomView.h
//  tt
//
//  Created by 黄鹏飞 on 2019/4/30.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveObjC.h"
NS_ASSUME_NONNULL_BEGIN

@interface JFCustomView : UIView

@property (nonatomic, strong) RACSubject *subject;
@end

NS_ASSUME_NONNULL_END
