//
//  WWUIWebViewController.m
//  WWDaily
//
//  Created by wangyongwang on 2018/9/11.
//  Copyright © 2018年 WYW. All rights reserved.
//

#import "WWUIWebViewController.h"

@implementation WWUIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str = @"https://www.so.com";
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    webView.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

@end
