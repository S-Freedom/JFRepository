//
//  DemoUtil.m
//  AAIClientDemo
//
//  Created by 贾立飞 on 2017/2/17.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import "DemoUtil.h"

#import <commoncrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
#include "base64.h"

@implementation DemoUtil

#pragma mark - util

+ (NSString *)hmacsha1:(NSString *)data secret:(NSString *)key
{
    NSData *secretData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *clearTextData = [data dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char result[20];
    CCHmac(kCCHmacAlgSHA1, [secretData bytes], [secretData length], [clearTextData bytes], [clearTextData length], result);
    char base64Result[32];
    size_t theResultLength = 32;
    Base64EncodeData(result, 20, base64Result, &theResultLength,YES);
    NSData *theData = [NSData dataWithBytes:base64Result length:theResultLength];
    NSString *base64EncodedResult = [[NSString alloc] initWithData:theData encoding:NSASCIIStringEncoding];
//    NSLog(@"计算签名的原串：=%@  key= %@",data,key);
//    NSLog(@"计算的签名的是:= %@",base64EncodedResult);
    return base64EncodedResult;
}


+ (NSString *)filterIllegalChar:(NSString *)str
{
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[\\p{P}~^<>]" options:NSRegularExpressionCaseInsensitive error:&error];//这个正则可以去掉所有的符号，空格除外
    NSString *modifiedString = [regex stringByReplacingMatchesInString:str options:0 range:NSMakeRange(0, [str length]) withTemplate:@""];
    NSString *replaceBlank=[modifiedString stringByReplacingOccurrencesOfString:@" " withString:@"_"];//再将空格转化成下划线，因为空格也不可以设置标签
   return replaceBlank;
}

// 汉子转拼音
+ (NSString *)convertHZ2PY:(NSString *)string{
    
    NSMutableString *mStr = [[NSMutableString alloc] initWithString:string];
    if (CFStringTransform((__bridge CFMutableStringRef)mStr, 0, kCFStringTransformMandarinLatin, NO)) {
//        NSLog(@"Pingying: %@", mStr);
    }
    
    if (CFStringTransform((__bridge CFMutableStringRef)mStr, 0, kCFStringTransformStripDiacritics, NO)) {
        NSLog(@"Pingying: %@", mStr);
        return mStr;
    }
    return @"";
}
@end
