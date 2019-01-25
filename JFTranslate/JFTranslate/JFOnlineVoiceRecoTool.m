//
//  JFOnlineVoiceRecoTool.m
//  JFTranslate
//
//  Created by 黄鹏飞 on 2019/1/18.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "JFOnlineVoiceRecoTool.h"
#import "Congfig.h"
#import "DemoUtil.h"
#import "QCloudAAIClient.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]
#define  kScreenWidth   ([UIScreen mainScreen].bounds.size.width)
#define  kScreenHeight  ([UIScreen mainScreen].bounds.size.height)

@interface JFOnlineVoiceRecoTool()<QCloudAAIGetSignDelegate>

@property (nonatomic, strong) QCloudAAIClient *client;
@property (nonatomic, assign) double silenceTime ;
@end

@implementation JFOnlineVoiceRecoTool

+ (instancetype)shareInstance{
    
    static JFOnlineVoiceRecoTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        tool = [[JFOnlineVoiceRecoTool alloc] init];
        [Congfig shareCongfig].appid = kAppId;
        [Congfig shareCongfig].projectId = kProjectId;
        [Congfig shareCongfig].sid = kSid;
        [Congfig shareCongfig].skey = kKey;
        tool.silenceTime = 5.0f;
    });
    return tool;
}

- (QCloudAAIClient *)client{
    if(!_client){
        NSLog(@"%@", kAppId);
        NSLog(@"%@", kSid);
        NSLog(@"%@", kProjectId);
        NSLog(@"%@", kKey);
        _client = [[QCloudAAIClient alloc] initWithAppid:kAppId secretid:kSid projectId:kProjectId];
        _client.delegate = self;
        [_client setSilenceTime:self.silenceTime];
        [_client openHTTPSrequset:YES];
        _client.res_type = 1;
        [_client setSilenceEndDetection:NO];
    }
    return _client;
}

-(NSString *)getRequestSign:(NSString *)param
{
    return [DemoUtil hmacsha1:param secret:kKey];
}

- (void)startHandler:(HandlerBlock)handler stateChange:(VoiceStateBlock)voiceState{
    
//    [self.client stop];
    
    [self.client startDetectionWihtCompletionHandle:^(QCloudAAIRsp *rsp) {
        NSString *voiceId = rsp.voiceId;
        NSString *text = rsp.text;
        NSString *descMsg = rsp.descMsg;
        int retCode = rsp.retCode;
        JFTentcentHandler *model = [[JFTentcentHandler alloc] init];
        model.voiceId = voiceId;
        model.text = text;
        model.descMsg = descMsg;
        model.retCode =retCode;
        handler(model);
    } stateChange:^(QCloudAAIState state) {
        NSLog(@"%@", @(state));
        VoiceState vState = @(state);
        voiceState(vState);
     }];
    
}

- (void)stop{
    [self.client stop];
}
@end
