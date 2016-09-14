//
//  MyViewController.m
//  优购淮北
//
//  Created by 李峰峰 on 15/8/21.
//  Copyright (c) 2015年 李峰峰. All rights reserved.
//

#import "MyViewController.h"
#import "MBProgressHUD+MJ.h"

@interface MyViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *MyWebView;
- (IBAction)backButtonClick;
@property(strong,nonatomic)MBProgressHUD *HUD;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.MyWebView.delegate = self;
    
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.labelText = @"正在加载";
    
    self.HUD = HUD;
    [HUD show:YES];
    
    
    NSURL *url = [NSURL URLWithString:@"http://www.ugohb.com/client/memttdz.php"];
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"testindex.html" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.MyWebView loadRequest:request];
    
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
    NSLog(@"didFailLoadWithError");
    [self.HUD hide:YES];
    [MBProgressHUD showError:@"没有网络连接"];
    CGFloat testheight = self.MyWebView.frame.size.height;
    NSLog(@"mywebview=%f",testheight);
}


- (IBAction)backButtonClick {
    if ([self.MyWebView canGoBack]) {
        [self.MyWebView goBack];
    }
}
@end
