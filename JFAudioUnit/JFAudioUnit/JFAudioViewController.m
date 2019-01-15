//
//  JFAudioViewController.m
//  GPUImageFilter
//
//  Created by 黄鹏飞 on 2018/12/7.
//  Copyright © 2018 com.hpf. All rights reserved.
//

#import "JFAudioViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioUnit/AudioUnit.h>
@interface JFAudioViewController ()
{
    
    AudioComponentInstance audioUnit;
}
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
    
    // 获得一个组件
    AudioComponent inputComponent = AudioComponentFindNext(NULL, &ioUnitDescription);
    // 使用扬声器
    
    // 获得audioUnit
    audioUnit = NULL;
    
    OSStatus status = noErr;
    UInt32 oneFlag = 1;
    UInt32 busZero = 0;
//    status = AudioUnitSetProperty(ioUnit, kAudioOutputUnitProperty_EnableIO, kAudioUnitScope_Output, busZero, &oneFlag, sizeof(oneFlag));
//    CheckStatus(status, @"Could not Connect To Speaker", YES);
    
    // 启用麦克风
    UInt32 busOne = 1;
    AudioUnitSetProperty(ioUnit, kAudioOutputUnitProperty_EnableIO, kAudioUnitScope_Input, busOne, &oneFlag, sizeof(oneFlag));
    CheckStatus(status, @"", YES);
    
    
    UInt32 bytesPerSample = sizeof(Float32);
    AudioStreamBasicDescription asbd;
    bzero(&asbd, sizeof(asbd));
    // 音频的编码格式
    asbd.mFormatID = kAudioFormatLinearPCM;
    asbd.mSampleRate = 44100;
    asbd.mChannelsPerFrame = 1;
    asbd.mFramesPerPacket = 1;
    asbd.mFormatFlags = kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked; //kAudioFormatFlagsNativeFloatPacked | kAudioFormatFlagIsNonInterleaved;
    asbd.mBitsPerChannel = 8 * bytesPerSample;
    asbd.mBytesPerFrame = bytesPerSample;
    asbd.mBytesPerPacket = bytesPerSample;
    
    // 设置格式
    status = AudioUnitSetProperty(audioUnit, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Output, 1, &asbd, sizeof(asbd));
    CheckStatus(status, @"", YES);
    
    status = AudioUnitSetProperty(audioUnit, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Input, 0, &asbd, sizeof(asbd));
    CheckStatus(status, @"", YES);
    
    AURenderCallbackStruct callbackStruct;
    callbackStruct.inputProc = recordingCallback;
    callbackStruct.inputProcRefCon = (__bridge void * _Nullable)(self);
    status = AudioUnitSetProperty(audioUnit, kAudioOutputUnitProperty_SetInputCallback, kAudioUnitScope_Global, 1, &callbackStruct, sizeof(callbackStruct));
    CheckStatus(status, @"", true);
    
    
    // 设置声音输出回调函数。当speaker需要数据时就会调用回调函数去获取数据。它是 "拉" 数据的概念。
    callbackStruct.inputProc = playbackCallback;
    callbackStruct.inputProcRefCon = (__bridge void * _Nullable)(self);
    status = AudioUnitSetProperty(audioUnit,
                                  kAudioUnitProperty_SetRenderCallback,
                                  kAudioUnitScope_Global,
                                  0,
                                  &callbackStruct,
                                  sizeof(callbackStruct));
    CheckStatus(status, @"", true);
    
    // 关闭为录制分配的缓冲区（我们想使用我们自己分配的）
    oneFlag = 0;
    status = AudioUnitSetProperty(audioUnit,
                                  kAudioUnitProperty_ShouldAllocateBuffer,
                                  kAudioUnitScope_Output,
                                  1,
                                  &oneFlag,
                                  sizeof(oneFlag));
    
    // 初始化
    status = AudioUnitInitialize(audioUnit);
    CheckStatus(status, @"", true);
    NSLog(@"%d", (int)status);
    
}

static OSStatus playbackCallback(void *inRefCon,
                                 AudioUnitRenderActionFlags *ioActionFlags,
                                 const AudioTimeStamp *inTimeStamp,
                                 UInt32 inBusNumber,
                                 UInt32 inNumberFrames,
                                 AudioBufferList *ioData) {
    // Notes: ioData 包括了一堆 buffers
    // 尽可能多的向ioData中填充数据，记得设置每个buffer的大小要与buffer匹配好。
    return noErr;
}

static OSStatus recordingCallback(void *inRefCon,
                                  AudioUnitRenderActionFlags *ioActionFlags,
                                  const AudioTimeStamp *inTimeStamp,
                                  UInt32 inBusNumber,
                                  UInt32 inNumberFrames,
                                  AudioBufferList *ioData) {
    
    // TODO:
    // 使用 inNumberFrames 计算有多少数据是有效的
    // 在 AudioBufferList 里存放着更多的有效空间
    
//    AudioBufferList *bufferList; //bufferList里存放着一堆 buffers, buffers的长度是动态的。
    
    // 获得录制的采样数据
    
    OSStatus status;
    
//    status = AudioUnitRender(audioUnit,
//                             ioActionFlags,
//                             inTimeStamp,
//                             inBusNumber,
//                             inNumberFrames,
//                             ioData);
//    CheckStatus(status, @"", true);

    // 现在，我们想要的采样数据已经在bufferList中的buffers中了。
//    DoStuffWithTheRecordedAudio(bufferList);
    return noErr;
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

#define VErr(err, msg)  do {\
if(nil != err) {\
NSLog(@"[ERR]:%@--%@", (msg), [err localizedDescription]);\
return ;\
}\
} while(0)

#define VStatus(err, msg) do {\
if(noErr != err) {\
NSLog(@"[ERR-%d]:%@", err, (msg));\
return ;\
}\
} while(0)

- (void)getAudioFileService{
    OSStatus stts;
    UInt32 infoSize = 0;
    stts = AudioFileGetGlobalInfoSize(kAudioFileGlobalInfo_AllMIMETypes, 0, NULL, &infoSize);
    VStatus(stts, @"AudioFileGetGlobalInfoSize");
    
    NSArray *MIMEs;
    stts = AudioFileGetGlobalInfo(kAudioFileGlobalInfo_AllMIMETypes, 0, NULL, &infoSize, &MIMEs);
    VStatus(stts, @"AudioFileGetGlobalInfo");
    NSLog(@"fileType is %@", MIMEs);
    
    UInt32 propertySize;
    OSType readOrwrite = kAudioFileGlobalInfo_ReadableTypes;
    
    stts = AudioFileGetGlobalInfoSize(readOrwrite, 0, NULL, &propertySize);
    VStatus(stts, @"AudioFileGetGlobalInfoSize");
    
    OSType *types = (OSType*)malloc(propertySize);
    stts = AudioFileGetGlobalInfo(readOrwrite, 0, NULL, &propertySize,  types);
    VStatus(stts, @"AudioFileGetGlobalInfo");
    
    UInt32 numTypes = propertySize / sizeof(OSType);
    for (UInt32 i=0; i<numTypes; ++i){
        CFStringRef name;
        UInt32 outSize = sizeof(name);
        stts = AudioFileGetGlobalInfo(kAudioFileGlobalInfo_FileTypeName, sizeof(OSType), types+i, &outSize, &name);
        VStatus(stts, @"AudioFileGetGlobalInfo");
        NSLog(@"readalbe types: %@", name);
    }
}


@end
