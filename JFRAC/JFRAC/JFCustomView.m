//
//  JFCustomView.m
//  tt
//
//  Created by 黄鹏飞 on 2019/4/30.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "JFCustomView.h"

@interface JFCustomView()

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIButton *btn1;
@end

@implementation JFCustomView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
    
        self.btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        self.btn.backgroundColor = [UIColor greenColor];
        [self.btn setTitle:@"clike me " forState:UIControlStateNormal];
        [self.btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btn];
        
        self.btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 0, 100, 100)];
        self.btn1.backgroundColor = [UIColor purpleColor];
        [self.btn1 setTitle:@"clike me1 " forState:UIControlStateNormal];
        [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btn1 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btn1];
    }
    return self;
}

- (void)btnClick:(UIButton *)sender{
    
    NSDictionary *dic = @{
                          @"sender" : sender,
                          @"color" : [UIColor redColor]
                          };
    [self.subject sendNext:dic];
}

- (void)btn1Click:(UIButton *)sender{
    
    NSDictionary *dic = @{
                          @"sender" : sender,
                          @"color" : [UIColor blueColor]
                          };
    [self.subject sendNext:dic];
}

- (RACSubject *)subject{
    if(!_subject){
        
        _subject = [RACSubject subject];
    }
    return _subject;
}
@end
