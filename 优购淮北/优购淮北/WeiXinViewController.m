//
//  WeiXinViewController.m
//  优购淮北
//
//  Created by 李峰峰 on 15/8/21.
//  Copyright (c) 2015年 李峰峰. All rights reserved.
//

#import "WeiXinViewController.h"
#import "MBProgressHUD+MJ.h"



@interface WeiXinViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *weixinWebview;
@property(strong,nonatomic)MBProgressHUD *HUD;

@end

@implementation WeiXinViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.weixinWebview.delegate = self;

    
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.labelText = @"正在加载";
    
    self.HUD = HUD;
    [HUD show:YES];
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://www.ugohb.com/client/myweb/weixin.html"];
//        NSURL *url = [[NSBundle mainBundle] URLForResource:@"testindex.html" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.weixinWebview loadRequest:request];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.HUD hide:YES];
}


#pragma  mark-UIWebViewDelegate方法
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.HUD hide:YES];
    NSLog(@"webViewDidFinishLoad");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.HUD hide:YES];
    NSLog(@"didFailLoadWithError");
    [MBProgressHUD showError:@"没有网络连接"];
}


@end