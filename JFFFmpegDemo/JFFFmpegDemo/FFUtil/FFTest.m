//
//  FFTest.m
//  JFFFmpegDemo
//
//  Created by 黄鹏飞 on 2019/6/13.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "FFTest.h"

@implementation FFTest

//测试FFmpeg配置
+(void)ffmpegTestConfig{
    
    const char *configuration = avcodec_configuration();
    NSLog(@"获取配置信息: %s", configuration);
}

//打开视频文件
+(void)ffmpegVideoOpenfile:(NSString*)filePath{
    
    // 注册组件
    av_register_all();
    
    // 打开封装格式文件
    // 获取格式上下文
    AVFormatContext *context = avformat_alloc_context();
    const char *url = [filePath UTF8String];
    
    int openResult = avformat_open_input(&context, url, NULL, NULL);
    if(openResult != 0){
        
        char *error_info = NULL;
        av_strerror(openResult, error_info, 1024);
        NSLog(@"打开文件失败");
        return;
    }
    NSLog(@"打开文件成功");
}

@end
