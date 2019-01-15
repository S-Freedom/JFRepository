//
//  ViewController.m
//  JFPadPro
//
//  Created by 黄鹏飞 on 2018/12/17.
//  Copyright © 2018 com.hpf. All rights reserved.
//

#import "ViewController.h"
#import "JFCollectionView.h"
#import "JFVoiceCell.h"

static NSString *cellId = @"voiceCellId";

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) JFCollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *items;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UINib *nib = [UINib nibWithNibName:@"JFVoiceCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:cellId];
    
    
    [self.view addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JFVoiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    return cell;
}

- (JFCollectionView *)collectionView{
    if(!_collectionView){
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        _collectionView = [[JFCollectionView alloc] initWithFrame:CGRectMake(0, 0, width, height) collectionViewLayout:self.flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if(!_flowLayout){
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(width, height);
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}
@end
