//
//  JFVoiceCell.m
//  JFPadPro
//
//  Created by 黄鹏飞 on 2018/12/17.
//  Copyright © 2018 com.hpf. All rights reserved.
//

#import "JFVoiceCell.h"
#import "JFProgressView.h"

@interface JFVoiceCell()
@property (weak, nonatomic) IBOutlet JFProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *tipImageView;

@property (weak, nonatomic) IBOutlet UILabel *esLable;
@property (weak, nonatomic) IBOutlet UILabel *enLabel;

@end

@implementation JFVoiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.esLable.font = [UIFont systemFontOfSize:14.0f];
    self.esLable.textColor = [UIColor blackColor];
    self.esLable.textAlignment = NSTextAlignmentCenter;
    
    self.enLabel.font = [UIFont systemFontOfSize:14.0f];
    self.enLabel.textColor = [UIColor blackColor];
    self.enLabel.textAlignment = NSTextAlignmentCenter;
    
    self.esLable.backgroundColor = [UIColor grayColor];
    self.enLabel.backgroundColor = [UIColor grayColor];
}

@end
