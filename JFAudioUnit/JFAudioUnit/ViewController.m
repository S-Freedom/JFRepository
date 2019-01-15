//
//  ViewController.m
//  JFAudioUnit
//
//  Created by 黄鹏飞 on 2018/12/11.
//  Copyright © 2018 com.hpf. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController () <AVAudioRecorderDelegate>

@property (nonatomic, strong) AVAudioRecorder *record;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, copy) NSString *audioURL;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UILabel *desLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *record = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 50, 50)];
    [record setTitle:@"record" forState:UIControlStateNormal];
    [record setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    record.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [record addTarget:self action:@selector(recordClick:) forControlEvents:UIControlEventTouchUpInside];
    record.tag = 1;
    [self.view addSubview:record];
    
    UIButton *pause = [[UIButton alloc] initWithFrame:CGRectMake(110, 100,50, 50)];
    [pause setTitle:@"pause" forState:UIControlStateNormal];
    [pause setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    pause.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [pause addTarget:self action:@selector(recordClick:) forControlEvents:UIControlEventTouchUpInside];
    pause.tag = 2;
    [self.view addSubview:pause];
    self.btn = pause;
    
    UIButton *stop = [[UIButton alloc] initWithFrame:CGRectMake(170, 100, 50, 50)];
    [stop setTitle:@"stop" forState:UIControlStateNormal];
    [stop setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    stop.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [stop addTarget:self action:@selector(recordClick:) forControlEvents:UIControlEventTouchUpInside];
    stop.tag = 3;
    [self.view addSubview:stop];
    
    UIButton *play = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 50, 50)];
    [play setTitle:@"play" forState:UIControlStateNormal];
    [play setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    play.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [play addTarget:self action:@selector(recordClick:) forControlEvents:UIControlEventTouchUpInside];
    play.tag = 4;
    [self.view addSubview:play];
    
    UIButton *pPause = [[UIButton alloc] initWithFrame:CGRectMake(110, 200, 50, 50)];
    [pPause setTitle:@"pPause" forState:UIControlStateNormal];
    [pPause setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    pPause.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [pPause addTarget:self action:@selector(recordClick:) forControlEvents:UIControlEventTouchUpInside];
    pPause.tag = 5;
    [self.view addSubview:pPause];
    
    UIButton *pStop = [[UIButton alloc] initWithFrame:CGRectMake(170, 200, 50, 50)];
    [pStop setTitle:@"pStop" forState:UIControlStateNormal];
    [pStop setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    pStop.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [pStop addTarget:self action:@selector(recordClick:) forControlEvents:UIControlEventTouchUpInside];
    pStop.tag = 6;
    [self.view addSubview:pStop];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 300, 100, 20)];
    label.text = @"...";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14.0f];
    self.desLabel = label;
    [self.view addSubview:self.desLabel];
    
}

- (void)requestMicAuthorizationWithBlock:(PermissionBlock)permission{
    
    [[AVAudioSession sharedInstance] requestRecordPermission:permission];
}

- (void)recordClick:(UIButton *)sender{
    NSInteger tag = sender.tag;
    
    switch (tag) {
        case 1:{
            __weak typeof(self) wSelf = self;
            [self requestMicAuthorizationWithBlock:^(BOOL granted) {
                
                if(!granted)  [self goSetting];
                if(![wSelf.record prepareToRecord]) return;
                
                [wSelf.record record];
                dispatch_async(dispatch_get_main_queue(), ^{
                    wSelf.desLabel.text = @"录制中...";
                });
            }];
        }
            break;
        case 2:
            if([self.record isRecording]){
                [self.record pause];
                self.desLabel.text = @"已暂停";
            }
            break;
        case 3:
            if(self.record){
                [self.record stop];
                self.desLabel.text = @"已停止";
            }
            break;
        case 4:
            if(self.player){
                [self.player play];
                self.desLabel.text = @"播放中...";
            }
            break;
        case 5:
        {
            if(self.player){
                [self.player pause];
                self.desLabel.text = @"播放暂停";
            }
        }
        case 6:
        {
            if(self.player){
                [self.player stop];
                self.desLabel.text = @"播放停止";
            }
        }
        break;
        default:
            break;
    }
}

- (void)goSetting{
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"麦克风未授权" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:cancleAction];
    [alert addAction:settingAction];
    [self presentViewController:alert animated:YES completion:nil];
}

/* audioRecorderDidFinishRecording:successfully: is called when a recording has been finished or stopped. This method is NOT called if the recorder is stopped due to an interruption. */
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    NSLog(@"%@ %ld", recorder, flag);
}

/* if an error occurs while encoding it will be reported to the delegate. */
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError * __nullable)error{
    NSLog(@"%@ %@", recorder, error);
}

- (AVAudioRecorder *)record{
    if(!_record){
        NSDictionary *info = @{
                               AVFormatIDKey:[NSNumber numberWithInt:kAudioFormatMPEG4AAC],//音频格式
                               AVSampleRateKey:@44100,//采样率
                               AVNumberOfChannelsKey:@1,//声道数
                               AVLinearPCMBitDepthKey:@16,//采样位数
                               AVLinearPCMIsBigEndianKey:@NO,
                               AVLinearPCMIsFloatKey:@NO,
                               AVEncoderAudioQualityKey:[NSNumber numberWithInt:AVAudioQualityHigh],
                               
                               };
        
        NSError *err;
        //    /*  混音播放，可以与其他音频应用同时播放 */
        //    AVAudioSessionCategoryAmbient
        //    /*  独占播放 */
        //    AVAudioSessionCategorySoloAmbient
        //    /* 后台播放，独占.*/
        //    AVAudioSessionCategoryPlayback
        //    /* 录音模式 */
        //    AVAudioSessionCategoryRecord
        //    /*  播放和录音，此时可以录音也可以播放 */
        //    AVAudioSessionCategoryPlayAndRecord
        //    /*  多种输入输出，例如可以耳机、USB设备同时播放 */
        //    AVAudioSessionCategoryMultiRoute
        if (@available(iOS 10.0, *)) {
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord mode:AVAudioSessionModeSpokenAudio options:AVAudioSessionCategoryOptionDefaultToSpeaker error:&err];
        } else {
            
        }
        
        NSURL *url = [NSURL URLWithString:self.audioURL];
        _record = [[AVAudioRecorder alloc] initWithURL:url settings:info error:&err];
        _record.delegate = self;
        [[AVAudioSession sharedInstance] setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
        
    }
    return _record;
}

- (AVAudioPlayer *)player{
    if(!_player){
        NSURL *url = [NSURL URLWithString:self.audioURL];
        NSError *err;
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&err];
    }
    return _player;
}

- (NSString *)audioURL{
    if(!_audioURL){
        _audioURL = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/recoder.aac"];
    }
    return _audioURL;
}

@end
