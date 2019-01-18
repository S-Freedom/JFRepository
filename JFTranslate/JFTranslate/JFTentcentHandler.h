//
//  JFTentcentModel.h
//  JFTranslate
//
//  Created by 黄鹏飞 on 2019/1/18.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFTentcentHandler : NSObject

/** 任务描述代码，为retCode = 0时标示成功，其他表示为失败 */
@property (nonatomic, assign)    int                    retCode;
/** 任务描述信息 */
@property (nonatomic, strong)    NSString               *descMsg;
/** 语音流的识别id */
@property (nonatomic, strong)    NSString               *voiceId;
/** 语音流的识别结果 */
@property (nonatomic, strong)    NSString               *text;
@end

NS_ASSUME_NONNULL_END
