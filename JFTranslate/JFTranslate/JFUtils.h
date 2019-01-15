//
//  JFUtils.h
//  JFTranslate
//
//  Created by 黄鹏飞 on 2019/1/15.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface JFUtils : NSObject

+ (CGSize)caculatorWithSting:(NSString *)string maxWidth:(CGFloat)maxWidth font:(UIFont *)font;

+(NSString *)md5HexDigest:(NSString *)aString;

+ (NSString *)URLEncodedString: (NSString*)input;
@end

NS_ASSUME_NONNULL_END
