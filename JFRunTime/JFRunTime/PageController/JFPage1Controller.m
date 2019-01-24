//
//  JFPage1Controller.m
//  JFRunTime
//
//  Created by 黄鹏飞 on 2019/1/23.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "JFPage1Controller.h"
#import <objc/runtime.h>
#import "JFPerson.h"

@interface JFPage1Controller ()

@property(nonatomic, strong) JFStudent *stu;

@end

@implementation JFPage1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    _stu = [JFStudent new];
    _stu.name = @"name";
    _stu.studyName = @"studyName";
    _stu.age = 18;
    
    JFClassRoom *room = [JFClassRoom new];
    room.studens = @[_stu];
    
//    [self copyStruct];
//    [self addIvar];
//    [self addProperty];
    [self methodInfo];
}

- (void)idStruct{
    NSLog(@"==========begin============");
    //    这是id类型的结构（类似于C里面的void *）：
    //    // 获取类的类名
    //    const char * class_getName ( Class cls );
    //    // 获取类的父类
    //    Class class_getSuperclass ( Class cls );
    //
    //    // 获取实例大小
    //    size_t class_getInstanceSize ( Class cls );
    //    // 获取类中指定名称实例成员变量的信息
    //    Ivar class_getInstanceVariable ( Class cls, const char *name );
    //    // 获取类成员变量的信息
    //    Ivar class_getClassVariable ( Class cls, const char *name );
    //    // 获取指定的属性
    //    objc_property_t class_getProperty ( Class cls, const char *name );
    //
    //    // 获取实例方法
    //    Method class_getInstanceMethod ( Class cls, SEL name );
    //    // 获取类方法
    //    Method class_getClassMethod ( Class cls, SEL name );
    //    // 获取方法的具体实现
    //    IMP class_getMethodImplementation ( Class cls, SEL name );
    //    IMP class_getMethodImplementation_stret ( Class cls, SEL name );
    const char *clsName = class_getName([JFStudent class]);
    Class suCls = class_getSuperclass([JFStudent class]);
    size_t size = class_getInstanceSize([JFStudent class]);
    Ivar insSuVar = class_getInstanceVariable([JFStudent class], "hobby");
    Ivar insVar = class_getInstanceVariable([JFStudent class], "priInfo");
    
    Ivar clsSuVar = class_getClassVariable([JFStudent class], "hobby");
    Ivar clsVar = class_getClassVariable([JFStudent class], "priInfo");
    
    objc_property_t suPro = class_getProperty([JFStudent class], "name");
    objc_property_t pro = class_getProperty([JFStudent class], "studyName");
    
    Method insM = class_getInstanceMethod([JFStudent class], @selector(isWalkingForSpeed:));
    Method clsM = class_getClassMethod([JFStudent class], @selector(getClassName));
    IMP imp = class_getMethodImplementation([JFStudent class], @selector(isWalkingForSpeed:));
    // 属性列表
    NSLog(@"clsName : -> %s", clsName);
    NSLog(@"suCls : -> %@", suCls);
    NSLog(@"size : -> %zu", size);
    //    NSLog(@"insSuVar : -> %@", insSuVar);
    //    NSLog(@"insVar : -> %@", insVar);
    //    NSLog(@"clsSuVar : -> %@", clsSuVar);
    //    NSLog(@"clsVar : -> %@", clsVar);
    //    NSLog(@"suPro : -> %@", suPro);
    //    NSLog(@"pro : -> %@", pro);
    //    NSLog(@"insM : -> %@", insM);
    //    NSLog(@"clsM : -> %@", clsM);
    //    NSLog(@"imp : -> %@", imp);
    NSLog(@"==========end============");
    free(insSuVar);
    free(insVar);
    free(clsSuVar);
    free(clsVar);
    free(suPro);
    free(pro);
    free(insM);
    free(clsM);
    free(imp);
}

- (void)copyStruct:(Class)cls{
//    // 获取整个成员变量列表
//    Ivar * class_copyIvarList ( Class cls, unsigned int *outCount );
//    // 获取属性列表
//    objc_property_t * class_copyPropertyList ( Class cls, unsigned int *outCount );
//    // 获取所有方法的列表
//    Method * class_copyMethodList ( Class cls, unsigned int *outCount );
//    // 获取类实现的协议列表
//    Protocol * class_copyProtocolList ( Class cls, unsigned int *outCount );
    
    NSLog(@"==========begin============");
    unsigned int outCount;
    
    printf("-----获取成员变量列表-----\n");
    /**
     *
     *  1.获取了所有的（.h .m）成员变量
     *  2.获取了属性的ivar: 如属性为studyName 则获取的是_studyName
     *  3.没有获取父类的属性和成员变量
     *
     */
    Ivar *ivarList = class_copyIvarList(cls, &outCount);
    for(int i =0; i<outCount; i++){
        const char *ivarName = ivar_getName(ivarList[i]);
        printf("%s \n", ivarName);
    }
    free(ivarList);
    
    printf("-----获取属性列表-----\n");
    /**
     *
     *  1.获取了所有的（.h .m）属性
     *  2.没有获取父类的属性和成员变量
     *
     */
    objc_property_t *proTList = class_copyPropertyList(cls, &outCount);
    for(int i =0; i< outCount; i++){
        const char *proName = property_getName(proTList[i]);
        printf("%s\n", proName);
    }
    free(proTList);
    
    printf("-----获取方法列表-----\n");
    /**
     *
     *  1.获取了所有的（.h .m）方法
     *  2.包括了.h .m 属性set get的方法
     *  3.没有获取父类的方法
     *
     */
    Method *clsMtdList = class_copyMethodList(cls, &outCount);
    for(int i =0; i< outCount; i++){
        SEL mSel = method_getName(clsMtdList[i]);
        printf("%s\n", mSel);
    }
    free(clsMtdList);
    printf("\n");
//    Protocol *pro = class_copyProtocolList([JFStudent class], &outCount);
    
    NSLog(@"==========end============");
}

- (void)addIvar{
//    // 添加成员变量
//    BOOL class_addIvar ( Class cls, const char *name, size_t size, uint8_t alignment, const char *types );
//    // 添加属性
//    BOOL class_addProperty ( Class cls, const char *name, const objc_property_attribute_t *attributes, unsigned int attributeCount );
//    // 添加方法
//    BOOL class_addMethod ( Class cls, SEL name, IMP imp, const char *types );
//    // 添加协议
//    BOOL class_addProtocol ( Class cls, Protocol *protocol );
    
    // 创建类,该类继承NSObject
    Class JFTempCls = objc_allocateClassPair([NSObject class], "JFTempCls", 0);
    // 为类添加成员变量
    BOOL flag1 = class_addIvar(JFTempCls, "_name", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
    if(flag1){
        printf("_tmpIvar 成员变量添加成功 \n");
    }
    
    BOOL flag2 = class_addIvar(JFTempCls, "_age", sizeof(int *), log2(sizeof(int *)), @encode(int *));
    if(flag2){
        printf("_tmpAge 成员变量添加成功 \n");
    }
    // 注册类,完成创建
    objc_registerClassPair(JFTempCls);
    
    // 实例化该类
    id cls = [[JFTempCls alloc] init];
    // 获取类的成员变量
    Ivar nameIvar = class_getInstanceVariable(JFTempCls, "_name");
    Ivar ageIvar = class_getInstanceVariable(JFTempCls, "_age");
    // 为成员变量赋值
    object_setIvar(cls, nameIvar, @"张三");
    object_setIvar(cls, ageIvar, @18);
    NSLog(@" %@ \n", object_getIvar(cls, nameIvar));
    NSLog(@"%@ \n", object_getIvar(cls, ageIvar));
    
    free(nameIvar);
    free(ageIvar);
}

#pragma mark -- 增加属性，增加参数
- (void)addProperty{
//    特性编码 具体含义
//    R readonly
//    C copy
//    & retain
//    N nonatomic
//    G(name) getter=(name)
//    S(name) setter=(name)
//    D @dynamic
//    W weak
//    P 用于垃圾回收机制
    
//    //替换类中的属性
//    void class_replaceProperty(Class cls, const char *name, const objc_property_attribute_t *attributes, unsigned int attributeCount)
//    //获取类中的属性
//    objc_property_t class_getProperty(Class cls, const char *name)
//    //拷贝类中的属性列表
//    objc_property_t *class_copyPropertyList(Class cls, unsigned int *outCount)
//    //获取属性名称
//    const char *property_getName(objc_property_t property)
//    //获取属性的特性
//    const char *property_getAttributes(objc_property_t property)
//    //拷贝属性的特性列表
//    objc_property_attribute_t *property_copyAttributeList(objc_property_t property, unsigned int *outCount)
//    //拷贝属性的特性的值
//    char *property_copyAttributeValue(objc_property_t property, const char *attributeName)
    
    Class smallStudent = objc_allocateClassPair([JFStudent class], "JFSmallStudent", 0);
    objc_registerClassPair(smallStudent);
    
    objc_property_attribute_t attr1;
    attr1.name = "T";
    attr1.value = @encode(NSString *);
    objc_property_attribute_t attr2 = {"N",""};         // nonatomic,value无意义时设置为空
    objc_property_attribute_t attr3 = {"C",""};         // copy
    objc_property_attribute_t attr4 = {"V","_subject"}; // 属性名
    objc_property_attribute_t attrs[] = {attr1, attr2, attr3, attr4};
    class_addProperty(smallStudent, "subject", attrs, 4);
    
    objc_property_attribute_t intAttr1 = {"T",@encode(NSInteger)};
    objc_property_attribute_t intAttr2 = {"N",""};
    objc_property_attribute_t intAttr3 = {"R",""};
    objc_property_attribute_t intAttr4 = {"W",""};
    objc_property_attribute_t intAttr5 = {"V","_readPro"};
    objc_property_attribute_t attrs1[] = {intAttr1, intAttr2, intAttr3, intAttr4, intAttr5};
    class_addProperty(smallStudent, "readPro", attrs1, 5);
    
    unsigned int count;
    // 获取属性列表
    objc_property_t *proList = class_copyPropertyList(smallStudent, &count);
    for(int i =0; i< count; i++){
        // 获取属性名称
        const char * proName = property_getName(proList[i]);
        // 获取属性参数
        const char * attrName = property_getAttributes(proList[i]);
        printf("proName %s \n", proName);
        printf("attrName %s \n", attrName);
    }
    
    // 重新增加属性，如果类当中本来就有这个属性的话，add不进去
    class_replaceProperty(smallStudent, "subject", attrs1, 5);
    
    objc_property_t *proList1 = class_copyPropertyList(smallStudent, &count);
    for(int i =0; i< count; i++){
        // 获取属性名称
        const char * proName = property_getName(proList1[i]);
        // 获取属性参数
        const char * attrName = property_getAttributes(proList1[i]);
        printf("proName %s \n", proName);
        printf("attrName %s \n", attrName);
    }

    // 获取指定属性
    objc_property_t subject = class_getProperty(smallStudent, "readPro");
    unsigned int outCount;
    // 获取参数列表
    objc_property_attribute_t *subAttr = property_copyAttributeList(subject, &outCount);
    for(int i =0; i< outCount; i++){
        objc_property_attribute_t attr = subAttr[i];
        printf(" name:%s , value: %s \n", attr.name , attr.value);
    }

    free(proList);
    free(proList1);
    free(subAttr);

}

- (void)methodInfo{
    
//    // 调用指定方法的实现
//    id method_invoke ( id receiver, Method m, ... );
//    // 调用返回一个数据结构的方法的实现
//    void method_invoke_stret ( id receiver, Method m, ... );
//    // 获取方法名
//    SEL method_getName ( Method m );
//    // 返回方法的实现
//    IMP method_getImplementation ( Method m );
//    // 获取描述方法参数和返回值类型的字符串
//    const char * method_getTypeEncoding ( Method m );
//    // 返回方法的参数的个数
//    unsigned int method_getNumberOfArguments ( Method m );
//    // 通过引用返回方法指定位置参数的类型字符串
//    void method_getArgumentType ( Method m, unsigned int index, char *dst, size_t dst_len );
//    // 获取方法的返回值类型的字符串
//    char * method_copyReturnType ( Method m );
//
//    // 获取方法的指定位置参数的类型字符串
//    char * method_copyArgumentType ( Method m, unsigned int index );
//
//    // 通过引用返回方法的返回值类型字符串
//    void method_getReturnType ( Method m, char *dst, size_t dst_len );
//    // 设置方法的实现
//    IMP method_setImplementation ( Method m, IMP imp );
//
//    // 交换两个方法的实现
//    void method_exchangeImplementations ( Method m1, Method m2 );
//
//    // 返回给定选择器指定的方法的名称
//    const char * sel_getName ( SEL sel );
//
//    // 在Objective-C Runtime系统中注册一个方法，将方法名映射到一个选择器，并返回这个选择器
//    SEL sel_registerName ( const char *str );
//
//    // 在Objective-C Runtime系统中注册一个方法
//    SEL sel_getUid ( const char *str );
//
//    // 比较两个选择器
//    BOOL sel_isEqual ( SEL lhs, SEL rhs );
//
    unsigned int outCount;
    Method *method = class_copyMethodList([JFPerson class], &outCount);
    for(int i=0; i<outCount; i++){
        Method m = method[i];
        SEL sel = method_getName(m);
        // 获取方法的实现
//        IMP imp = class_getMethodImplementation([JFPerson class], sel);
        
        const char * getTypeEncoding = method_getTypeEncoding(m);
        struct objc_method_description *desc = method_getDescription(m);
        // v void
        // b BOOL
        // : NSArray
        // @ NSString, NSDictionary
        // @? Block
        const char * returnType = method_copyReturnType(m);
        NSLog(@"sel %@", NSStringFromSelector(sel));
        printf("getTypeEncoding %s \n", getTypeEncoding);
        printf("desc %s \n", desc);
        printf("returnType %s \n", returnType);
        
        printf("\n");
        unsigned int numberOfArgument = method_getNumberOfArguments(m);
        for(unsigned i =0; i< numberOfArgument; i++){
            const char * argumentType = method_copyArgumentType(m, i);
            printf("argumentType %s \n", argumentType);
        }
        
        
    }
}

@end
