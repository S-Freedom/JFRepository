//
//  JFTanView.h
//  JFTanDemo
//
//  Created by 黄鹏飞 on 2018/12/27.
//  Copyright © 2018 com.hpf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JFTanViewDelegate, JFTanViewDataSource;

@interface JFTanView : UIView

@property (nonatomic, assign) NSUInteger showPages;
@property (nonatomic, weak) id<JFTanViewDelegate> delegate;
//数据源
@property (nonatomic, weak) id<JFTanViewDataSource> dataSource;
//设置偏移量
@property (nonatomic, assign) CGSize offSet;
//显示的第一个View
@property (nonatomic, strong , readonly) UIView *topView;

//刷新展示数据
- (void)refreshData;

- (void)viewDismissFromLeft:(UIView *)view;

@end

@protocol JFTanViewDataSource <NSObject>
@required
- (NSInteger)numberOfItemInTan:(JFTanView *)tantan;

- (UIView *)tantan:(JFTanView *)tantan
viewForItemAtIndex:(NSInteger)index
       reusingView:(UIView *)view;
@end

/*---------------------------------------------------------------*/
@protocol JFTanViewDelegate <NSObject>
@optional
- (void)tantan:(JFTanView *)tantan beforeSwipingItemAtIndex:(NSInteger)index;
- (void)tantan:(JFTanView *)tantan didRemovedItemAtIndex:(NSInteger)index;
- (void)tantan:(JFTanView *)tantan didLeftRemovedItemAtIndex:(NSInteger)index;
- (void)tantan:(JFTanView *)tantan didRightRemovedItemAtIndex:(NSInteger)index;

@end
NS_ASSUME_NONNULL_END
