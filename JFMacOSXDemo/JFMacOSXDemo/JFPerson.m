//
//  JFSong.m
//  JFMacOSXDemo
//
//  Created by 黄鹏飞 on 2019/6/25.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "JFPerson.h"

@implementation JFPerson

- (instancetype)init{
    
    if(self = [super init]){
        
        self.name = @"ben";
        self.address = @"北京";
    }
    return self;
}
@end
