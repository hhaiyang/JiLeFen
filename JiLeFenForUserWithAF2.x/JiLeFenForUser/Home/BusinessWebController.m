//
//  BusinessWebController.m
//  JiLeFenForUser
//
//  Created by hhy on 16/9/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BusinessWebController.h"

@interface BusinessWebController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation BusinessWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"商家详情";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回按钮" height:30];
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    NSURL *url = [NSURL URLWithString:_urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];

}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
