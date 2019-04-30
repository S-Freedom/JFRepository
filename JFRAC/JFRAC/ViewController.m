//
//  ViewController.m
//  JFRAC
//
//  Created by 黄鹏飞 on 2019/4/30.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveObjC.h"
#import "JFCustomView.h"

@interface ViewController ()

@property (nonatomic, strong) id<RACSubscriber> subscriber;

@property (nonatomic, strong) JFCustomView *customerView;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, strong) RACDisposable *dispose;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    [self replaceDelegate];
    [self replaceKVO];
    [self replaceEvent];
    [self replaceTextField];
    [self replaceNoti];
//    [self replaceTimer];
}

- (void)replaceTimer{
    
    __weak typeof(self) wSelf = self;
    self.dispose = [[RACSignal interval:1.0f onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
       
        if(wSelf.time <= 0){
            wSelf.btn.enabled = YES;
            [wSelf.dispose dispose];
            wSelf.time = 10;
            return ;
        }
        wSelf.time--;
        NSString *str = [NSString stringWithFormat:@"倒计时%.0f秒", wSelf.time];
        [wSelf.btn setTitle:str forState:UIControlStateNormal];
        NSLog(@"%@ ,%@", x, str);
    }];
}

- (void)replaceDelegate{
    
    // RAC代替代理
    [[self.customerView rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(RACTuple * _Nullable x) {
        
        NSLog(@"%s\n btnClick%@",__func__, x);
    }];
    
    [[self.customerView rac_signalForSelector:@selector(btn1Click:)] subscribeNext:^(RACTuple * _Nullable x) {
        
        NSLog(@"%s\n btnClick%@",__func__, x);
    }];
}

// RAC代替KVO
- (void)replaceKVO{
    
    [[self.customerView rac_valuesForKeyPath:@"frame" observer:nil] subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"%s\n%@",__func__, x);
    }];
}

// RAC代替事件
- (void)replaceEvent{
    
    self.time = 10;

    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.btn.enabled = NO;
        [self replaceTimer];
    }];
}

- (void)replaceTextField{
    
    // 监听输入框的变化
    [self.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        
        NSLog(@"%s\n%@",__func__, x);
    }];
}

// 代替通知
- (void)replaceNoti{
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        
        NSLog(@"%s\n%@",__func__, x);
    }];
}

- (void)createUI{
    
    self.customerView = [[JFCustomView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    self.customerView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.customerView];
    
    self.btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 200, 100)];
    self.btn.backgroundColor = [UIColor greenColor];
    [self.btn setTitle:@"rac click" forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:self.btn];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 350, 100, 30)];
    self.textField.placeholder = @"请输入...";
    [self.view addSubview:self.textField];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
    CGRect rect = self.customerView.frame;
    rect.origin.x += 5;
    self.customerView.frame = rect;
}

- (void)createSinnal1{
    // 创建信号
    RACSubject *subject = [RACSubject subject];
    [subject subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"接受信号%@", x);
    }];
    
    [subject sendNext:@"1024"];
}

- (void)createSinnal2{
    // 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        // 发送信号
        [subscriber sendNext:@"Hello CC!"];
        
        _subscriber = subscriber;
        // 取消订阅
        return [RACDisposable disposableWithBlock:^{
            
            NSLog(@"订阅被取消");
        }];
    }];
    
    // 订阅信号
    RACDisposable *disposeable = [signal subscribeNext:^(id  _Nullable x) {
        
    }];
    
    [disposeable dispose];

}

- (void)jfTuple{
    
    RACTuple *tuple = [RACTuple tupleWithObjects:@[@"aaa",@"bbb",@123], nil];
    
    // RACSequence用于地代替NSARRAY, NSDIC
    // 可以快速遍历， 数据解析，字典转模型
    // RAC集合，将数组中的元素作为发送信号的内容
    RACSequence *requence = [tuple rac_sequence];
    RACSignal *signal = [requence signal];
    // 遍历数组1
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    // 遍历数组2
    [tuple.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    // 遍历字典
    NSDictionary *dict = @{@"name":@"张三",@"age":@18};
    [dict.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        
        // func1
        NSString *key = x[0];
        NSString *value = x[1];
        NSLog(@"%@ : %@", key, value);
        
        // func2
        RACTupleUnpack(NSString *key1, NSString *value1) = x;
        NSLog(@"RACTupleUnpack    %@ : %@", key1, value1);
    }];
}
@end
