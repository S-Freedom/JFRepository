//
//  ViewController.m
//  JFPopover
//
//  Created by 黄鹏飞 on 2018/12/10.
//  Copyright © 2018 com.hpf. All rights reserved.
//

#import "ViewController.h"
#import "JFPopOverViewController.h"
#import "JFCell.h"
@interface ViewController () <UIPopoverPresentationControllerDelegate>

@property (nonatomic, strong) UIButton *btn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *clickBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    [clickBtn setTitle:@"click" forState:UIControlStateNormal];
    [clickBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    clickBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [clickBtn addTarget:self action:@selector(recordClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickBtn];
    
    UIButton *showBtn = [[UIButton alloc] initWithFrame:CGRectMake(350, 100, 100, 100)];
    [showBtn setTitle:@"show" forState:UIControlStateNormal];
    [showBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    showBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:showBtn];
    self.btn = showBtn;
}

- (void)recordClick:(UIButton *)sender{
    
    JFPopOverViewController *popOverVC = [[JFPopOverViewController alloc] init];
    popOverVC.view.backgroundColor = [UIColor lightGrayColor];
    popOverVC.preferredContentSize = CGSizeMake(100, 200);
    popOverVC.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popController = popOverVC.popoverPresentationController;
    popController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    popController.delegate = self;
    popController.sourceRect = CGRectMake(0, -30, 100, 100);
    popController.sourceView = self.btn;
    popController.backgroundColor = [UIColor lightGrayColor];
    
    [self presentViewController:popOverVC animated:YES completion:nil];
}


#pragma mark --UIPopoverPresentationController
- (void)prepareForPopoverPresentation:(UIPopoverPresentationController *)popoverPresentationController{
    NSLog(@"%s", __func__);
}

#pragma mark --ShouldDismiss of the view.
- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    NSLog(@"%s", __func__);
    return NO;
}
// Called on the delegate when the user has taken action to dismiss the popover. This is not called when the popover is dimissed programatically.
- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    NSLog(@"%s", __func__);
}
// -popoverPresentationController:willRepositionPopoverToRect:inView: is called on your delegate when the
// popover may require a different view or rectangle.
- (void)popoverPresentationController:(UIPopoverPresentationController *)popoverPresentationController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView  * __nonnull * __nonnull)view{
    NSLog(@"%s", __func__);
}

@end
