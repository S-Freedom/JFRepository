//
//  JRFileManager.h
//  JingRuiOnlineSchool
//
//  Created by 黄鹏飞 on 2018/12/28.
//  Copyright © 2018 onesmart. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JRFileModelType) {
    JRFileModelVoiceSpokenType = 1 << 0
};


@interface JRFileManager : NSObject

+ (instancetype)sharedInstance;

/**
 *
 *   保存数据
 *   @param data 二进制数据
 *   @param fileName 文件名
 *   @param type 模块类型
 *
 */
+ (NSString *)saveData:(NSData *)data fileName:(NSString *)fileName type:(JRFileModelType)type;

/**
 *
 *   语音测评目录
 *
 */
+ (NSString *)voiceFolderPath;
/**
 *
 *   移除文件夹
 *   @param folderName 文件夹名称
 *
 */
+ (void)removeFolder:(NSString *)folderName;

/**
 *
 *   移除文件
 *   @param fileName 文件名称
 *   @param modelType 模块类型
 *
 */
+ (void)removeFile:(NSString *)fileName folder:(JRFileModelType)modelType;

/**
 *
 *   移除根目录
 *
 */
+ (void)removeRootFolder;

/**
 *
 *   获取当前日期字符串
 *
 */
- (NSString *)getCurrentDataString;

@end

NS_ASSUME_NONNULL_END
