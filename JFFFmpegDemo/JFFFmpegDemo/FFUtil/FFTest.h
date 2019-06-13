//
//  FFTest.h
//  JFFFmpegDemo
//
//  Created by 黄鹏飞 on 2019/6/13.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import <Foundation/Foundation.h>
//引入头文件
//核心库->音视频编解码库
#import <libavcodec/avcodec.h>
//导入封装格式库
#import <libavformat/avformat.h>

NS_ASSUME_NONNULL_BEGIN

@interface FFTest : NSObject

//测试FFmpeg配置
+(void)ffmpegTestConfig;

//打开视频文件
+(void)ffmpegVideoOpenfile:(NSString*)filePath;
@end

NS_ASSUME_NONNULL_END
