//
//  JFCollectionView.m
//  JFPadPro
//
//  Created by 黄鹏飞 on 2018/12/17.
//  Copyright © 2018 com.hpf. All rights reserved.
//

#import "JFCollectionView.h"

@implementation JFCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if(self = [super initWithFrame:frame collectionViewLayout:layout]){
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
