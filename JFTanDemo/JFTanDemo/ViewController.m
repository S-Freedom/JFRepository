//
//  ViewController.m
//  JFTanDemo
//
//  Created by 黄鹏飞 on 2018/12/27.
//  Copyright © 2018 com.hpf. All rights reserved.
//

#import "ViewController.h"
#import "JFTanView.h"
#import "JFView.h"
#import "JFModel.h"
#import "JRFileManager.h"

#define kRandomColor     [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]

@interface ViewController () <JFTanViewDataSource>

@property (nonatomic, strong) NSMutableArray *viewArr;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) JFTanView *tanView;
@property (nonatomic, strong) UIButton *nextLeftBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tanView = [[JFTanView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
//    self.tanView.center = self.view.center;
//    self.tanView.dataSource = self;
//    self.tanView.showPages = 3;
//    [self.view addSubview:self.tanView];
//
//    [self.view addSubview:self.nextLeftBtn];
    
    NSLog(@"%d", arc4random()%100);
    NSLog(@"%d", arc4random()%100);
    NSLog(@"%d", arc4random()%100);
    
    
    JFModel *model = [[JFModel alloc] init];
    model.name = @"name1";
    model.age = 21;
    
    JFModel *model1 = [[JFModel alloc] init];
    model1.name = @"name2";
    model1.age = 22;
    
    JFModel *model2 = [[JFModel alloc] init];
    model2.name = @"name3";
    model2.age = 23;
    
    NSArray *arr = @[model, model1, model2];
    
    NSString *filePath = [[JRFileManager voiceFolderPath] stringByAppendingString:@"user1oice001.archiver"];
    NSLog(@"%@", filePath);

    if (@available(iOS 12.0, *)) {
        
        NSError *err = nil;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr requiringSecureCoding:NO error:&err];
        if([data writeToFile:filePath atomically:YES]){
            NSLog(@"success");
        }

        NSData *getData = [NSData dataWithContentsOfFile:filePath];
        
        NSSet *set = [NSSet setWithObjects:[NSArray class],[JFModel class], nil];
        NSArray *arr2 = [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:getData error:&err];
        for(JFModel *model in arr2){
            NSLog(@"%@", model.name);
            NSLog(@"%lu", (unsigned long)model.age);
        }
    }else{
        if([NSKeyedArchiver archiveRootObject:arr toFile:filePath]){
            NSLog(@"success");
        }
        
        NSArray *arr2 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        for(JFModel *model in arr2){
            NSLog(@"%@", model.name);
            NSLog(@"%lu", (unsigned long)model.age);
        }
    }
}

- (BOOL)saveData:(id)object fileName:(NSString *)fileName{
    
    if(!object) return NO;
    if(fileName.length == 0) return NO;
    
    NSString *filePath = [[JRFileManager voiceFolderPath] stringByAppendingString:fileName];
    if (@available(iOS 12.0, *)) {
        
        NSError *err = nil;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object requiringSecureCoding:NO error:&err];
        if(![data writeToFile:filePath atomically:YES]){
            NSLog(@"%@", err);
            return NO;
        }
    }else{
        
        if(![NSKeyedArchiver archiveRootObject:object toFile:filePath]){
            NSLog(@"error!");
            return NO;
        }
    }
    return YES;
}

- (id)getDataWithFileName:(NSString *)fileName{
    
    if(!fileName) return nil;
    NSString *filePath = [[JRFileManager voiceFolderPath] stringByAppendingString:fileName];
    if (@available(iOS 12.0, *)) {
        
        NSError *err = nil;
        NSData *getData = [NSData dataWithContentsOfFile:filePath];
        NSSet *set = [NSSet setWithObjects:[NSArray class],[JFModel class], nil];
        NSArray *arr = [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:getData error:&err];
        return arr;
    }else{

        NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        return arr;
    }
    return nil;
}

- (NSInteger)numberOfItemInTan:(JFTanView *)tantan{
     return self.dataArr.count;
}

- (UIView *)tantan:(JFTanView *)tantan viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    //    if(view) return view;
    
    if(self.dataArr.count <= index) return nil;
    
    NSString *str = self.dataArr[index];
    JFView *tanView = [self createTanView];
    tanView.tag = index;
    [tanView loadString:str];
//    NSLog(@"tanView:%p, %@",tanView, str);
    return tanView;
}

- (JFView *)createTanView{
    JFView *tanView = [[JFView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
    tanView.backgroundColor = kRandomColor;
    return tanView;
}

- (NSMutableArray *)viewArr{
    if(!_viewArr){
        _viewArr = [NSMutableArray arrayWithCapacity:10];
    }
    return _viewArr;
}

- (NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14", nil];
        
    }
    return _dataArr;
}

- (UIButton *)nextLeftBtn{
    if(!_nextLeftBtn){
        _nextLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 50, 40)];
        [_nextLeftBtn setTitle:@"Next" forState:UIControlStateNormal];
        [_nextLeftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_nextLeftBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextLeftBtn;
}

- (void)nextBtnClick{
    [self.tanView viewDismissFromLeft:nil];
}
@end
