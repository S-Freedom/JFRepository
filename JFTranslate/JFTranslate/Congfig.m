//
//  Congfig.m
//  QCAAIClientApp
//
//  Created by 贾立飞 on 2017/3/17.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import "Congfig.h"

@implementation Congfig

+(instancetype)shareCongfig {
    
    static Congfig *g_instance = nil;
    
    static  dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        g_instance =[[Congfig alloc] init];
    });
    return g_instance;
}



@end
