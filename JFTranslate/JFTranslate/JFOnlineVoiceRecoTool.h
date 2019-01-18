//
//  JFOnlineVoiceRecoTool.h
//  JFTranslate
//
//  Created by 黄鹏飞 on 2019/1/18.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFTentcentHandler.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    /*! 语音识别打开  */
    VoiceStateOpen = 0,
    /*! 语音识别关闭  */
    VoiceStateClose,
    /*! 语音识别失败，麦克风权限没有开启  */
    VoiceStateFail,
} VoiceState;

typedef void(^HandlerBlock)(JFTentcentHandler *handler);
typedef void(^VoiceStateBlock)(VoiceState state);

@interface JFOnlineVoiceRecoTool : NSObject

+ (instancetype)shareInstance;
- (void)startHandler:(HandlerBlock)handler stateChange:(VoiceStateBlock)voiceState;
- (void)stop;
@end

NS_ASSUME_NONNULL_END
