//
//  ViewController.m
//  JFOpenCV2Study
//
//  Created by 黄鹏飞 on 2019/6/6.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "ViewController.h"
#import "JFImageUtils.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *originBtn;
@property (weak, nonatomic) IBOutlet UIButton *masacBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.image = [UIImage imageNamed:@"Test1.jpg"];
}

- (IBAction)originBtnClick:(UIButton *)sender {

    self.imageView.image = [UIImage imageNamed:@"Test1.jpg"];
}

- (IBAction)masacBtnClick:(UIButton *)sender {

    self.imageView.image = [JFImageUtils opcvImage:self.imageView.image level:20];
}

@end
