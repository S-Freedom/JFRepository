//
//  JFView.m
//  JFTanDemo
//
//  Created by 黄鹏飞 on 2018/12/27.
//  Copyright © 2018 com.hpf. All rights reserved.
//

#import "JFView.h"

@interface JFView()

@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation JFView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        self.titleLabel.textColor = [UIColor blackColor];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)loadString:(NSString *)str{
    self.titleLabel.text = str;
}
@end

