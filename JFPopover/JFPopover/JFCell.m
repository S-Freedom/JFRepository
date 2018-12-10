//
//  JFCell.m
//  GPUImageFilter
//
//  Created by 黄鹏飞 on 2018/12/10.
//  Copyright © 2018 com.hpf. All rights reserved.
//

#import "JFCell.h"

@interface JFCell()
@property (nonatomic, strong) UILabel *lbl;
@end

@implementation JFCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
        lbl.textColor = [UIColor blackColor];
        lbl.font = [UIFont systemFontOfSize:14];
        self.lbl = lbl;
        [self.contentView addSubview:lbl];
    }
    return self;
}

- (void)setContent:(NSString *)str{
    self.lbl.text = str;
}
@end
