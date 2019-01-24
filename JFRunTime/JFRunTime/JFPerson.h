//
//  JFPerson.h
//  JFRunTime
//
//  Created by 黄鹏飞 on 2019/1/23.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface JFPerson : NSObject
{
    int hobby;
    NSString *priInfo;
}
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) NSMutableArray *arms;
@property (nonatomic, assign) NSMutableDictionary *infoDic;
@property (nonatomic, copy) void (^eatBlock)(void);
@property (nonatomic, copy) void (^walkBlock)(NSString *road);

- (void)eat;
- (void)run:(CGFloat)speed;
- (BOOL)isWalking;
/**
 *  返回是否走路，传入速度和工具
 *  @param speed 速度  tool 工具
 *  @return BOOL 返回yes or no
 */
- (BOOL)isWalking:(CGFloat)speed tool:(NSString *)tool;
- (BOOL)isWalkingForSpeed:(CGFloat)speed;
- (NSString *)getFirstName;
+ (NSString *)getClassName;
+ (void)getClassInfo;
@end

@interface JFStudent : JFPerson

@property (nonatomic, copy) NSString *studyName;

- (void)studyWithName:(NSString *)sName;
@end

@protocol JFClassRoomDelegate <NSObject>

- (void)classRoomJoinDelegate:(NSString *)stuName;
- (NSString *)classRoomGetStuNameDelegate;
@end

@interface JFClassRoom : NSObject

@property (nonatomic, weak) id<JFClassRoomDelegate> delegate;
@property (nonatomic, strong) NSArray<JFStudent *> *studens;

- (NSInteger)stuCount;
- (NSString *)stuNames;
+ (void)study;
@end


NS_ASSUME_NONNULL_END
