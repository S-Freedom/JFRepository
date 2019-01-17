//
//  ViewController.m
//  JFTranslate
//
//  Created by 黄鹏飞 on 2019/1/17.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "ViewController.h"
#import "JRNetworking.h"
#import "JFUtils.h"
#import <AFNetworking/AFNetworking.h>
#import <CommonCrypto/CommonDigest.h>

typedef enum : NSUInteger {
    JFBaiduTranslateType,
    JFYoudaoTranslateType
} JFTranslateType;

@interface ViewController()

@property (nonatomic, assign) JFTranslateType type;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *resultLabel;
@property (nonatomic, strong) NSURLSessionDataTask *task;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = JFBaiduTranslateType;
    [self loadUI];
}

- (void)loadUI{
    NSArray *arr = [NSArray arrayWithObjects:@"百度",@"有道", nil];
    CGFloat x = 20;
    CGFloat y = 20;
    CGFloat width = self.view.bounds.size.width / arr.count - 20;
    CGFloat height = 50;
    for(NSUInteger i=0; i<arr.count; i++){
        NSString *str = arr[i];
        CGRect frame = CGRectMake(x += width * i, y, width, height);
        UIButton *btn = [self createBtnWithTitle:str frame:frame ide:i];
        [self.view addSubview:btn];
        if(i == 0){
            self.selectBtn = btn;
            btn.selected = YES;
        }
    }
    CGFloat textY = 20 + 50 + 20;
    CGFloat textWidth = self.view.bounds.size.width - 40 - 50;
    CGFloat textHeight = 140;
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(20, textY, textWidth, textHeight)];
    //    textView.borderStyle = UITextBorderStyleRoundedRect;
//    textView.text = @"今天早上带着四岁的女儿来幼儿园上班,我在打扫卫生,给她一块抹布让她去擦滑滑梯,她一屁股从滑滑梯滑下来说:妈妈,擦干净啦";
    textView.text = @"苹果";
    textView.layer.borderColor = [UIColor blackColor].CGColor;
    textView.layer.borderWidth = 1.0f;
    self.textView = textView;
    [self.view addSubview:textView];
    
    CGRect fyFrame = CGRectMake(CGRectGetMaxX(textView.frame), textY, 50, 40);
    UIButton *fyBtn = [[UIButton alloc] initWithFrame:fyFrame];
    [fyBtn setTitle:@"翻译" forState:UIControlStateNormal];
    [fyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fyBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    fyBtn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [fyBtn addTarget:self action:@selector(translateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fyBtn];
    
    CGFloat labelY = CGRectGetMaxY(textView.frame) +20;
    CGFloat resultWidth = textWidth + 50;
    UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, labelY, resultWidth, self.view.bounds.size.height - labelY - 20)];
    resultLabel.text = @"";
    resultLabel.font = [UIFont systemFontOfSize:14.0f];
    resultLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    resultLabel.layer.borderWidth = 1.0f;
    resultLabel.numberOfLines = 0;
    resultLabel.preferredMaxLayoutWidth = resultWidth;
    resultLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.resultLabel = resultLabel;
    [self.view addSubview:resultLabel];
}

- (UIButton *)createBtnWithTitle:(NSString *)title frame:(CGRect)frame ide:(NSInteger)tag{
    
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    btn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    return btn;
}

- (void)btnClick:(UIButton *)sender{
    
    self.selectBtn.selected = NO;
    sender.selected = YES;
    self.selectBtn = sender;
    NSInteger tag = sender.tag;
    
    if(tag == 0){
        self.type = JFBaiduTranslateType;
    }else if(tag == 1){
        self.type = JFYoudaoTranslateType;
    }
}

- (void)translateBtnClick:(UIButton *)sender{
    
    NSString *urlStr = @"";
    if(self.type == JFBaiduTranslateType){
        urlStr = @"http://10.3.244.89:8081/baiduTrans";
    }else if(self.type == JFYoudaoTranslateType){
        urlStr = @"http://10.3.244.89:8081/youDaoTrans";
    }
    
    __weak typeof(self) wSelf = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.textView.text forKey:@"text"];
    [params setObject:@"zh" forKey:@"from"];
    [params setObject:@"en" forKey:@"to"];
    
    self.task = [JRNetworkingSingleton dataTaskWithRequest:request params:params header:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {

        NSDictionary *dic = responseObject;
        NSLog(@"dic %@",dic);
        NSString *dst = [[dic[@"dst"] stringByRemovingPercentEncoding] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSString *src = [[dic[@"src"] stringByRemovingPercentEncoding] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSLog(@"dst: %@", dst);
        NSLog(@"src: %@", src);
        CGRect rect =  wSelf.resultLabel.frame;
        UIFont *font = wSelf.resultLabel.font;
        CGFloat height = [JFUtils caculatorWithSting:dst maxWidth:rect.size.width-10 font:font].height + 40;
        rect.size.height = height;
        dispatch_async(dispatch_get_main_queue(), ^{
            wSelf.resultLabel.text = dst;
            wSelf.resultLabel.frame = rect;
        });

    }];
    
    [self.task resume];
}
@end
