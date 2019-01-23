//
//  ViewController.m
//  JFRunTime
//
//  Created by 黄鹏飞 on 2019/1/23.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "ViewController.h"

#import "PageController/JFPage1Controller.h"
#import "PageController/JFPage2Controller.h"
#import "PageController/JFPage3Controller.h"
#import "PageController/JFPage4Controller.h"
#import "PageController/JFPage5Controller.h"

@interface ViewController () <TYPagerControllerDelegate, TYPagerControllerDataSource>

@property (nonatomic, strong) JFPage1Controller *page1VC;
@property (nonatomic, strong) JFPage2Controller *page2VC;
@property (nonatomic, strong) JFPage3Controller *page3VC;
@property (nonatomic, strong) JFPage4Controller *page4VC;
@property (nonatomic, strong) JFPage5Controller *page5VC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerClass:[JFPage1Controller class] forControllerWithReuseIdentifier:NSStringFromClass([JFPage1Controller class])];
    [self registerClass:[JFPage2Controller class] forControllerWithReuseIdentifier:NSStringFromClass([JFPage2Controller class])];
    [self registerClass:[JFPage3Controller class] forControllerWithReuseIdentifier:NSStringFromClass([JFPage3Controller class])];
    [self registerClass:[JFPage4Controller class] forControllerWithReuseIdentifier:NSStringFromClass([JFPage4Controller class])];
    [self registerClass:[JFPage5Controller class] forControllerWithReuseIdentifier:NSStringFromClass([JFPage5Controller class])];
    self.delegate = self;
    self.dataSource = self;
}

// viewController's count in pagerController
- (NSInteger)numberOfControllersInPagerController{
    return 5;
}

/* 1.viewController at index in pagerController
 2.if prefetching is YES,the controller is preload,not display.
 3.if controller will display,will call viewWillAppear.
 4.you can register && dequeue controller, usage like tableView
 */
- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching{
    if(index == 0) return self.page1VC;
    if(index == 1) return self.page2VC;
    if(index == 2) return self.page3VC;
    if(index == 3) return self.page4VC;
    if(index == 4) return self.page5VC;
    return self.page1VC;
}

// Display customization
// the same to viewWillAppear, also can use viewController's viewWillAppear
- (void)pagerController:(TYPagerController *)pagerController viewWillAppear:(UIViewController *)viewController forIndex:(NSInteger)index{
    NSLog(@"%s", __func__);
}

- (void)pagerController:(TYPagerController *)pagerController viewDidAppear:(UIViewController *)viewController forIndex:(NSInteger)index{
    NSLog(@"%s", __func__);
}

// Disappear customization
// the same to viewWillDisappear, also can use viewController's viewWillDisappear
- (void)pagerController:(TYPagerController *)pagerController viewWillDisappear:(UIViewController *)viewController forIndex:(NSInteger)index{
    NSLog(@"%s", __func__);
}

- (void)pagerController:(TYPagerController *)pagerController viewDidDisappear:(UIViewController *)viewController forIndex:(NSInteger)index{
    NSLog(@"%s", __func__);
}
// Transition animation customization

- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated{
    NSLog(@"%s", __func__);
}

- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress{
    NSLog(@"%s", __func__);
}

// ScrollViewDelegate

- (void)pagerControllerDidScroll:(TYPagerController *)pagerController{
    NSLog(@"%s", __func__);
}

- (void)pagerControllerWillBeginScrolling:(TYPagerController *)pagerController animate:(BOOL)animate{
    NSLog(@"%s", __func__);
}

- (void)pagerControllerDidEndScrolling:(TYPagerController *)pagerController animate:(BOOL)animate{
    NSLog(@"%s", __func__);
}

- (JFPage1Controller *)page1VC{
    if(!_page1VC){
        _page1VC = [JFPage1Controller new];
        _page1VC.title = @"1";
    }
    return _page1VC;
}

- (JFPage2Controller *)page2VC{
    if(!_page2VC){
        _page2VC = [JFPage2Controller new];
        _page1VC.title = @"2";
    }
    return _page2VC;
}
- (JFPage3Controller *)page3VC{
    if(!_page3VC){
        _page3VC = [JFPage3Controller new];
        _page1VC.title = @"3";
    }
    return _page3VC;
}
- (JFPage4Controller *)page4VC{
    if(!_page4VC){
        _page4VC = [JFPage4Controller new];
        _page1VC.title = @"4";
    }
    return _page4VC;
}
- (JFPage5Controller *)page5VC{
    if(!_page5VC){
        _page5VC = [JFPage5Controller new];
        _page1VC.title = @"5";
    }
    return _page5VC;
}
@end
