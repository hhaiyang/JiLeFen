//
//  ActivityViewController.m
//  优购淮北
//
//  Created by 李峰峰 on 15/8/21.
//  Copyright (c) 2015年 李峰峰. All rights reserved.
//

#import "ActivityViewController.h"
#import "MBProgressHUD+MJ.h"

@interface ActivityViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *activityWebView;
- (IBAction)backButtonClick;
@property(strong,nonatomic)MBProgressHUD *HUD;

@end

@implementation ActivityViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.activityWebView.delegate = self;

    
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.labelText = @"正在加载";
    
    self.HUD = HUD;
    [HUD show:YES];
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://www.ugohb.com/client2/myweb/award.html"];
    //    NSURL *url = [[NSBundle mainBundle] URLForResource:@"testindex.html" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.activityWebView loadRequest:request];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.HUD hide:YES];
}



#pragma  mark-UIWebViewDelegate方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    [self.HUD show:YES];
    
    return true;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.HUD hide:YES];
    NSLog(@"webViewDidFinishLoad");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.HUD hide:YES];
    NSLog(@"didFailLoadWithError");
    [MBProgressHUD showError:@"没有网络连接"];
    CGFloat testheight = self.activityWebView.frame.size.height;
    NSLog(@"mywebview=%f",testheight);
}


- (IBAction)backButtonClick {
    if ([self.activityWebView canGoBack]) {
        [self.activityWebView goBack];
    }
}
@end
