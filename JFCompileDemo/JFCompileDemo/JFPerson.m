//
//  JFPerson.m
//  JFCompileDemo
//
//  Created by 黄鹏飞 on 2019/4/2.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "JFPerson.h"
#import <objc/runtime.h>
#import "JFSafeForwarding.h"

@implementation JFPerson

- (void)say:(NSString *)name{
    
    NSLog(@"hello, %@", name);
}

- (void)test1{
    
    NSLog(@"test");
}

void replaceTest(id obj, SEL _cmd, NSString *name, int age){
    
    NSLog(@"name : %@ age: %d", name, age);
}

//  第一次拯救
//  如如果返回YES，实例方法可以在这个方法里面动态增加方法的实现
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    
    if(sel == @selector(test:age:)){
        
        class_addMethod([self class], sel, (IMP)replaceTest, "v@:");
        return YES;
    }
    return [super resolveClassMethod:sel];
}

//  第一次拯救
//  如果返回YES，类方法可以在这个方法里面动态增加方法的实现
+ (BOOL)resolveClassMethod:(SEL)sel{
    
    if(sel == @selector(test:age:)){
        
        class_addMethod([self class], sel, (IMP)replaceTest, "v@:");
        return YES;
    }
    return [super resolveClassMethod:sel];
}

// 第二次拯救
// 如果resolveXXXMethod返回NO 且目标对象实现了这个方法，Runtime会把这个消息转发给其他对象。
// 这个过程不会创建新的对象
- (id)forwardingTargetForSelector:(SEL)aSelector{
    
    JFSafeForwarding *safeForwarding = [[JFSafeForwarding alloc] init];
    if([safeForwarding respondsToSelector:aSelector]){
        return safeForwarding;
    }
    return [super forwardingTargetForSelector:aSelector];
}


// 第三次拯救
// 如果forwardingTargetForSelector 返回nil或者self,且实现了这个方法，
// 首先它会发送 - methodSignatureForSelector:消息获取函数的参数和返回值类型，如果返回nil
// Runtime 发送 - doesNotRecognizeSelector:方法，进程结束
// 如果返回了一个函数签名，Runtime 就会创建一个 NSInvocation 对象并发送 -forwardInvocation: 消息给目标对象。
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if(!signature){
        JFSafeForwarding *safeForwarding = [[JFSafeForwarding alloc] init];
        signature = [safeForwarding methodSignatureForSelector:aSelector];
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    
    SEL sel = anInvocation.selector;
    JFSafeForwarding *safeForwarding = [[JFSafeForwarding alloc] init];
    if([safeForwarding respondsToSelector:sel]){
        
        [anInvocation invokeWithTarget:safeForwarding];
    }else{
        [self doesNotRecognizeSelector:sel];
    }
}
@end
