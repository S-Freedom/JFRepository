//
//  JFTanView.m
//  JFTanDemo
//
//  Created by 黄鹏飞 on 2018/12/27.
//  Copyright © 2018 com.hpf. All rights reserved.
//

#import "JFTanView.h"

@interface JFTanView()

@property (nonatomic, strong) NSMutableArray *itemArr;
@property (nonatomic, strong) NSMutableArray *totalArr;
@end

@implementation JFTanView

- (instancetype)init{
    if(self = [super init]){
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setup];
    }
    return self;
}

- (void)setup{
    
    self.showPages = 3;
    self.offSet = CGSizeMake(10, 10);
    [self refreshData];
}

- (void)setShowPages:(NSUInteger)showPages{
    _showPages = showPages;

    [self refreshData];
}

- (void)refreshData{
    
    NSUInteger showPages = self.showPages;
    if([self.dataSource respondsToSelector:@selector(numberOfItemInTan:)]){
        NSUInteger total = [self.dataSource numberOfItemInTan:self];
        if(self.totalArr.count >= total) return;
        
        if([self.dataSource respondsToSelector:@selector(tantan:viewForItemAtIndex:reusingView:)]){
            for(NSInteger i = 0; i< showPages; i++){
                [self loadNextPage];
            }
        }
    }
    
    [self layoutViews];
}

- (void)loadNextPage{
    
    UIView *view = [self.dataSource tantan:self viewForItemAtIndex:self.totalArr.count reusingView:[UIView new]];
    if(!view) return;
    
    [self.itemArr addObject:view];
    [self.totalArr addObject:view];
    [self insertSubview:view atIndex:0];
}

- (void)layoutViews{
    
    NSInteger num = MIN(self.itemArr.count, self.showPages);
    if (num<=0) {
        return;
    }
    
    CGFloat width = self.frame.size.width;
    CGFloat height  = self.frame.size.height;
    //水平偏移量
    CGFloat horizonOffset = _offSet.width;
    //垂直偏移量
    CGFloat verticalOffset = _offSet.height;
    
    UIView *firstView = [self.itemArr firstObject];
    CGFloat viewW = firstView.frame.size.width;
    CGFloat viewH = firstView.frame.size.height;
    
    CGFloat firstViewX = (width - viewW) * 0.5;
    CGFloat firstViewY = (height - viewH) * 0.5;
    [UIView animateWithDuration:0.01 animations:^{
        for (NSInteger i = 0; i<num; i++) {
            UIView *tantan = self.itemArr[i];
            // 每次以最大值为准递减
            tantan.frame = CGRectMake(firstViewX + i * horizonOffset, firstViewY + i *verticalOffset, width - i * horizonOffset * 2, height);
        }
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)viewDismissFromLeft:(UIView *)view{
    
    if(!view){
        view = self.itemArr.firstObject;
    }
    
    if(self.itemArr.count == 1) return;
    CGPoint finishPoint = CGPointMake(-500, view.center.y);
    //动画
    [UIView animateWithDuration:0.3 animations:^{
        view.center = finishPoint;
    } completion:^(BOOL finished) {
        [self viewRemove:view];
    }];
}

- (void)viewDismissFromRight:(UIView *)view{
    if(!view){
        view = self.itemArr.firstObject;
    }
    
    if(self.itemArr.count == 1) return;
    CGPoint finishPoint = CGPointMake(self.bounds.size.width + 500, view.center.y);
    //动画
    [UIView animateWithDuration:0.3 animations:^{
        view.center = finishPoint;
    } completion:^(BOOL finished) {
        [self viewRemove:view];
    }];
}

- (void)viewRemove:(UIView *)view{
    
    [view removeFromSuperview];
    [self.itemArr removeObject:view];
    
    [self loadNextPage];
    // 增加一个
    [self layoutViews];
}

- (NSMutableArray *)itemArr{
    if(!_itemArr){
        _itemArr = [NSMutableArray array];
    }
    return _itemArr;
}

- (NSMutableArray *)totalArr{
    if(!_totalArr){
        _totalArr = [NSMutableArray array];
    }
    return _totalArr;
}

@end
