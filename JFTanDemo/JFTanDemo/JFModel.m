//
//  JFModel.m
//  JFTanDemo
//
//  Created by 黄鹏飞 on 2018/12/28.
//  Copyright © 2018 com.hpf. All rights reserved.
//

#import "JFModel.h"

@implementation JFModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    if(self = [super init]){
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}

+ (BOOL)supportsSecureCoding{
    return YES;
}

//- (BOOL)isNeedReplaceSandBox{
//
//    NSString *path = _name;
//    NSRange range = [path rangeOfString:@"/tmp/"];
//    NSString *str = [path substringToIndex:range.location + range.length];
//    NSLog(@"%@", str);
//    if(![str isEqualToString:NSTemporaryDirectory()]){
//        return YES;
//    }
//    return NO;
//}
//
//- (NSString *)replacePathForTemoDir:(NSString *)path{
//
//    if(!path) return nil;
//    NSRange range = [path rangeOfString:@"tmp/"];
//    NSString *str = [path substringFromIndex:range.location+range.length];
//    NSString *replacePath = [NSTemporaryDirectory() stringByAppendingString:str];
//    NSLog(@"%@", replacePath);
//    return replacePath;
//}

@end
