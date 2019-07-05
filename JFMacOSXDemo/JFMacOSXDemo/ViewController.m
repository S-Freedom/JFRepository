//
//  ViewController.m
//  JFMacOSXDemo
//
//  Created by 黄鹏飞 on 2019/6/25.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "ViewController.h"
#import "JFPerson.h"

@interface ViewController()
@property (strong) IBOutlet NSArrayController *arrayController;

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    for (int i =0; i<10; i++) {
        [self.dataArray addObject:[JFPerson new]];
    }
    NSDictionary *options = @{NSAllowsEditingMultipleValuesSelectionBindingOption:@YES };
    [self.arrayController bind:@"contentArray"
                      toObject:self
                   withKeyPath:@"dataArray"
                       options:options];
}
@end
