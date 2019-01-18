//
//  Congfig.h
//  QCAAIClientApp
//
//  Created by 贾立飞 on 2017/3/17.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Congfig : NSObject

@property (nonatomic,strong)  NSString * appid;
@property (nonatomic, strong) NSString   *projectId;
@property (nonatomic, strong) NSString   *sid;
@property (nonatomic, strong) NSString   *skey;

+(instancetype)shareCongfig;

@end
