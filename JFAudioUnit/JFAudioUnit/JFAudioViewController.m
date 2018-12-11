//
//  JFAudioViewController.m
//  GPUImageFilter
//
//  Created by 黄鹏飞 on 2018/12/7.
//  Copyright © 2018 com.hpf. All rights reserved.
//

#import "JFAudioViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface JFAudioViewController ()

@end

@implementation JFAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDesc];
}
    
- (void)loadDesc{
    AudioComponentDescription ioUnitDescription;
    ioUnitDescription.componentType = kAudioUnitType_Output;
    ioUnitDescription.componentSubType = kAudioUnitSubType_RemoteIO;
    ioUnitDescription.componentManufacturer = kAudioUnitManufacturer_Apple;// 厂商
    ioUnitDescription.componentFlags = 0;
    ioUnitDescription.componentFlagsMask = 0;
    
    // 创建AUDIOUnit 的第一种方式
//    AudioComponent ioUnitRef = AudioComponentFindNext(NULL, &ioUnitDescription);
//    AudioUnit ioUnitInstance;
//    AudioComponentInstanceNew(ioUnitRef, &ioUnitInstance);
    
    // 创建AUDIOUnit 的第二种方式,扩展性能更好，所以推荐使用
    AUGraph prossingGraph;
    NewAUGraph(&prossingGraph);
    AUNode ioNode;
    AUGraphAddNode(prossingGraph, &ioUnitDescription, &ioNode);
    AUGraphOpen(prossingGraph);
    AudioUnit ioUnit;
    AUGraphNodeInfo(prossingGraph, ioNode, NULL, &ioUnit);
    
    // 使用扬声器
    OSStatus status = noErr;
    UInt32 oneFlag = 1;
    UInt32 busZero = 0;
    status = AudioUnitSetProperty(ioUnit, kAudioOutputUnitProperty_EnableIO, kAudioUnitScope_Output, busZero, &oneFlag, sizeof(oneFlag));
    CheckStatus(status, @"Could not Connect To Speaker", YES);
    
    
    // 启用麦克风
    UInt32 busOne = 1;
    AudioUnitSetProperty(ioUnit, kAudioOutputUnitProperty_EnableIO, kAudioUnitScope_Input, busOne, &oneFlag, sizeof(oneFlag));
    
    UInt32 bytesPerSample = sizeof(Float32);
    AudioStreamBasicDescription asbd;
    bzero(&asbd, sizeof(asbd));
    // 音频的编码格式
    asbd.mFormatID = kAudioFormatLinearPCM;
    asbd.mSampleRate = 44100;
    asbd.mChannelsPerFrame = 1;
    asbd.mFramesPerPacket = 1;
    asbd.mFormatFlags = kAudioFormatFlagsNativeFloatPacked | kAudioFormatFlagIsNonInterleaved;
    asbd.mBitsPerChannel = 8 * bytesPerSample;
    asbd.mBytesPerFrame = bytesPerSample;
    asbd.mBytesPerPacket = bytesPerSample;
}

static void CheckStatus(OSStatus status, NSString *message, BOOL flag){
    
    if(status != noErr){
        char fourCC[16];
        *(UInt32 *)fourCC = CFSwapInt32HostToBig(status);
        fourCC[4] = '\0';
        if(isprint(fourCC[0]) && isprint(fourCC[1]) && isprint(fourCC[2]) && isprint(fourCC[3])){
            NSLog(@"%@    %s", message, fourCC);
        }else{
            NSLog(@"%@ : %d", message, (int)status);
        }
        if(flag){
            exit(-1);
        }
    }
}

//
//kAudioUnitType_Output                    = 'auou',
//kAudioUnitType_MusicDevice                = 'aumu',
//kAudioUnitType_MusicEffect                = 'aumf',
//kAudioUnitType_FormatConverter            = 'aufc',
//kAudioUnitType_Effect               = 'aufx',
//kAudioUnitType_Mixer                    = 'aumx',
//kAudioUnitType_Panner                    = 'aupn',
//kAudioUnitType_Generator                = 'augn',
//kAudioUnitType_OfflineEffect            = 'auol',
//kAudioUnitType_MIDIProcessor            = 'aumi'
/**
 *
 *
 *      AudioUnit的分类
 *      EffectUnit: kAudioUnitType_Effect,主要提供声音特效处理的功能，其子类主要用于说明
 *      均衡效果器：子类型是kAudioUnitSubType_NBandEQ， 主要作用是为声音的某些频带增强或者减弱能量
 *      压缩效果器：子类型是kAudioUnitSubType_DynamicsProcessor ，主要作用是当声音过小的时候可以提高声音的音量，当声音超过设定的法制时，可以降低音量
 *      混响效果器： 子类型是kAudioUnitSubType_Reverb2,对于人声处理来讲是非常重要的效果器，入股有非常多的反射声音和原始声音叠加在一起，那么从听感上可能会更有震撼力，但是同时原始声音也会变得更加模块，原始声音的一些细节会被遮盖掉，所以混响设置大小对于不同的人来说会不一致，
 *
 *
 *
 */
@end
