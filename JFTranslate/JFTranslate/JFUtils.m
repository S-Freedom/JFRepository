//
//  JFUtils.m
//  JFTranslate
//
//  Created by 黄鹏飞 on 2019/1/15.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "JFUtils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation JFUtils

// 计算文本高度
+ (CGSize)caculatorWithSting:(NSString *)string maxWidth:(CGFloat)maxWidth font:(UIFont *)font{
    return [string boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}


+(NSString *)md5HexDigest:(NSString *)aString{
    const char *original_str = [aString UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    
    return [hash lowercaseString];
}

/*
 **
 *  URLEncode
 */
+ (NSString *)URLEncodedString: (NSString*)input
{
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *unencodedString = input;
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}
@end
