//
//  JFView.m
//  JFRunTime
//
//  Created by 黄鹏飞 on 2019/1/29.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "JFView.h"
#import "JFGetController.h"

@implementation JFView


- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
         NSLog(@"JFPage1Controller  %@", [JFGetController getCurrentVC]);
        
    }
    return self;
}

@end
