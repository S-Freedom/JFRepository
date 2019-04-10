//
//  JFPage2Controller.m
//  JFRunTime
//
//  Created by 黄鹏飞 on 2019/1/23.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "JFPage2Controller.h"
#import "JFGetController.h"
#import "JFView.h"
@interface JFPage2Controller ()

@end

@implementation JFPage2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor = [UIColor blueColor];
    
    JFView *v  = [[JFView alloc] initWithFrame:self.view.bounds];
    v.backgroundColor = [UIColor grayColor];
    [self.view addSubview:v];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"JFPage2Controller  %p", [JFGetController getCurrentVC]);
    UIViewController *vc = [JFGetController getCurrentVC];
    NSArray *arr = vc.childViewControllers;
    NSLog(@"%@", arr);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
