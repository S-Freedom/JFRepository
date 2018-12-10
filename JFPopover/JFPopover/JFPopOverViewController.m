//
//  JFPopOverViewController.m
//  GPUImageFilter
//
//  Created by 黄鹏飞 on 2018/12/10.
//  Copyright © 2018 com.hpf. All rights reserved.
//

#import "JFPopOverViewController.h"
#import "JFCell.h"
@interface JFPopOverViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
    
@end

@implementation JFPopOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, 200) style:UITableViewStylePlain];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}


    //MARK:UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    JFCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(!cell){
        cell = [[JFCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSString *str = [NSString stringWithFormat:@"lbl%ld", indexPath.row];
    [cell setContent:str];
    return cell;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    
    [self dismissViewControllerAnimated:NO completion:nil];
}
    
@end
