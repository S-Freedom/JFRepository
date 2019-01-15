//
//  JRFileManager.m
//  JingRuiOnlineSchool
//
//  Created by 黄鹏飞 on 2018/12/28.
//  Copyright © 2018 onesmart. All rights reserved.
//

#import "JRFileManager.h"

static NSString *const kVoiceSpoken_Folder = @"VoiceSpoken/";

@interface JRFileManager()

@end

@implementation JRFileManager

- (instancetype)init {
    if (self = [super init]) {
        [self createSubdirectory];
    }
    return self;
}

- (void)createSubdirectory {
    
    [self createFolder:kVoiceSpoken_Folder];
}

+ (instancetype)sharedInstance{
    
    static JRFileManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JRFileManager alloc] init];
    });
    return manager;
}

- (void)createFolder:(NSString *)folderName{
    
    NSString *folderPath = [[JRFileManager rootPath] stringByAppendingString:folderName];
    if([[self class] folderIsExist:folderPath]) return;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:&error];
}

+ (void)removeFolder:(NSString *)folderName{
    
    NSString *folderPath = [[JRFileManager rootPath] stringByAppendingString:folderName];
    if([[self class] folderIsExist:folderPath]) return;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *fileErr;
    [fileManager removeItemAtPath:folderPath error:&fileErr];
}

+ (void)removeFile:(NSString *)fileName folder:(JRFileModelType)modelType{
    
    if(fileName.length == 0) return;
    if(!modelType) return;
    
    NSString *folderPath = [[JRFileManager sharedInstance] getFolderPath:modelType];
    NSString *filePath = [folderPath stringByAppendingString:fileName];
    if([[self class] folderIsExist:filePath]) return;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *fileErr;
    [fileManager removeItemAtPath:filePath error:&fileErr];
}

+ (NSString *)saveData:(NSData *)data fileName:(NSString *)fileName type:(JRFileModelType)type{
    if(!data)return @"";
    if(fileName.length <= 0) return @"";
    if(!type) return @"";
    
    NSString *rootPath = nil;
    if(type == JRFileModelVoiceSpokenType) {
        rootPath = [JRFileManager voiceFolderPath];
    }
    
    NSString *filePath = [rootPath stringByAppendingString:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:filePath]) {
        NSError *removeErr;
        [fileManager removeItemAtPath:filePath error:&removeErr];
    }
    [data writeToFile:filePath atomically:YES];
    return filePath;
}

- (BOOL)hasRootDirectory {
    NSString *rootDic = [JRFileManager rootPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:rootDic]) {
        return YES;
    }
    return NO;
}

+ (NSString *)rootPath {
    
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    
    NSString *folderPath = [NSString stringWithFormat:@"/"];
    return [docPath stringByAppendingString:folderPath];
}

- (NSString *)getFolderPath:(JRFileModelType)modelType {
    NSString *path = nil;
    switch (modelType) {
        case JRFileModelVoiceSpokenType:
            path =  [[JRFileManager rootPath] stringByAppendingString:kVoiceSpoken_Folder];
            break;
        default:
            path =  [[JRFileManager rootPath] stringByAppendingString:kVoiceSpoken_Folder];
            break;
    }
    return path;
}

+ (NSString *)voiceFolderPath {
    return [[self rootPath] stringByAppendingString:kVoiceSpoken_Folder];
}

- (NSString *)getCurrentDataString {
    
    // eg:20180303-122115521-金麟扫描
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    int random = arc4random_uniform(100);
    [dateFormatter setDateFormat:@"YYYYMMdd-hhmmsssss"];
    //    导入相册时，存在毫秒级别内同时导入多个文件的问题，需加一个随机数，防止多个文件名重复
    //    NSString *dateStr = [[dateFormatter stringFromDate:date] stringByAppendingString:[NSString stringWithFormat:@"%d", random]];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

// 判断根目录是否已经存在，用于异常场景恢复
- (BOOL)rootFileExist {
    NSString *rootPath = [JRFileManager rootPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:rootPath]) {
        return YES;
    }
    return NO;
}

+ (BOOL)folderIsExist:(NSString *)folderPath{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:folderPath]) {
        return YES;
    }
    return NO;
}

+ (void)removeRootFolder {
    NSString *rootPath = [self rootPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *fileErr;
    [fileManager removeItemAtPath:rootPath error:&fileErr];
}

@end
