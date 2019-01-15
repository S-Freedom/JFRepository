//
//  ViewController.m
//  JFTranslate
//
//  Created by 黄鹏飞 on 2019/1/14.
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

@interface ViewController ()

@property (nonatomic, assign) JFTranslateType type;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *resultLabel;
@property (nonatomic, strong) NSURLSessionDataTask *task;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = JFYoudaoTranslateType;
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
        if(i == 1){
            self.selectBtn = btn;
            btn.selected = YES;
        }
    }
    CGFloat textY = 20 + 50 + 20;
    CGFloat textWidth = self.view.bounds.size.width - 40 - 50;
    CGFloat textHeight = 140;
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(20, textY, textWidth, textHeight)];
//    textView.borderStyle = UITextBorderStyleRoundedRect;
    textView.text = @"今天早上带着四岁的女儿来幼儿园上班,我在打扫卫生,给她一块抹布让她去擦滑滑梯,她一屁股从滑滑梯滑下来说:妈妈,擦干净啦";
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
    
    if(self.type == JFBaiduTranslateType){
        
    }else if(self.type == JFYoudaoTranslateType){
        
        NSString *urlStr = @"http://fanyi.youdao.com/translate_o?smartresult=dict&smartresult=rule";
        NSString *text = self.textView.text;
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSString *salt = [NSString stringWithFormat:@"%ld", (long)([NSDate new].timeIntervalSince1970*1000)+ (long)(arc4random()%10 + 1)];
        NSString *signStr = [NSString stringWithFormat:@"fanyideskweb%@%@p09@Bn{h02_BIEe]$P^nG", text, salt];
        NSString *sign = [JFUtils md5HexDigest:signStr];
        [params setObject:text forKey:@"i"];
        [params setObject:salt forKey:@"salt"];
        [params setObject:sign forKey:@"sign"];
        [params setObject:@"zh-CHS" forKey:@"from"];
        [params setObject:@"en" forKey:@"to"];
        [params setObject:@"dict" forKey:@"smartresult"];
        [params setObject:@"fanyideskweb" forKey:@"client"];
        [params setObject:@"json" forKey:@"doctype"];
        [params setObject:@"2.1" forKey:@"version"];
        [params setObject:@"fanyi.web" forKey:@"keyfrom"];
        [params setObject:@"FY_BY_CLICKBUTTION" forKey:@"action"];
        [params setObject:@"false" forKey:@"typoResult"];
        long ctime = (long)[NSDate date].timeIntervalSince1970 * 1000;
        
        NSMutableDictionary *header = [NSMutableDictionary dictionary];
        [header setValue:[NSString stringWithFormat:@"OUTFOX_SEARCH_USER_ID=819492325@10.168.1.241; JSESSIONID=aaayu6S9Te0-t_kJMebHw; OUTFOX_SEARCH_USER_ID_NCOO=727553669.6778518; DICT_SESS=v2|MiNWGDWChzY6Mwz0LUWROY0M6LRfzE0eLOfOM6Lwy0e40HwShMk5RT40Mzlh4eL0wBOMQFkLUA0OAO4JZ0feFRUMRfYGOfOA0; DICT_LOGIN=1||1547279965579; SESSION_FROM_COOKIE=unknown; DICT_UGC=be3af0da19b5c5e6aa4e17bd8d90b28a|; JSESSIONID=abcgDuN9ePdr3beZN1kHw; _ntes_nnid=71c769867ee541788c72b47e738df2a7,1547444206018; ___rl__test__cookies=1547529900556%zd", ctime] forKey:@"Cookie"];
        [header setValue:@"http://fanyi.youdao.com/" forKey:@"Referer"];
        [header setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36" forKey:@"User-Agent"];
        
        __weak typeof(self) wSelf = self;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        self.task = [JRNetworkingSingleton dataTaskWithRequest:request params:params header:header completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            
            NSArray *array = responseObject[@"translateResult"];
            NSMutableString *result = [NSMutableString string];
            for (NSArray *subarray in array) {
                for (NSDictionary *dic in subarray) {
                    NSLog(@"%@:%@", dic[@"src"], dic[@"tgt"]);
                    [result appendString:dic[@"tgt"]];
                }
            }
            
            CGRect rect =  wSelf.resultLabel.frame;
            UIFont *font = wSelf.resultLabel.font;
            CGFloat height = [JFUtils caculatorWithSting:result maxWidth:rect.size.width-10 font:font].height + 40;
            rect.size.height = height;
            dispatch_async(dispatch_get_main_queue(), ^{
                wSelf.resultLabel.text = result;
                wSelf.resultLabel.frame = rect;
            });
            
        }];
        
        [self.task resume];
    }
    
}
@end
