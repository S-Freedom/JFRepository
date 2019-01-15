//
//  ViewController.m
//  JFWebView
//
//  Created by 黄鹏飞 on 2019/1/10.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
@interface ViewController () <WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *wkWebView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建WKWebView
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.wkWebView.navigationDelegate = self;
    [self.view addSubview:self.wkWebView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://sit-www.juren.cn/learn/homework?id=635&dest=pad"]];
    [self.wkWebView loadRequest:request];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"%s", __func__);
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"%s, %@", __func__, navigation);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"%s, %@", __func__, navigation);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"%s, %@", __func__, navigation);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"%s, %@", __func__, navigation);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"%s, %@", __func__, navigation);
}
@end
