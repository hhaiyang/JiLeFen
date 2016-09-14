//
//  RecommendViewController.m
//  优购淮北
//
//  Created by 李峰峰 on 15/8/21.
//  Copyright (c) 2015年 李峰峰. All rights reserved.
//

#import "RecommendViewController.h"
#import "MBProgressHUD+MJ.h"

@interface RecommendViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;
- (IBAction)sendButtonClick;
@property (strong, nonatomic) IBOutlet UIWebView *detailWebView;

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailWebView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:@"http://www.ugohb.com/client2/introduction/introduction1.html"];
    //    NSURL *url = [[NSBundle mainBundle] URLForResource:@"testindex.html" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.detailWebView loadRequest:request];
    
}





#pragma  mark-UIWebViewDelegate方法
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

    [MBProgressHUD showError:@"没有网络连接"];
}



- (IBAction)sendButtonClick {
    NSURL *url = [NSURL URLWithString:@"http://www.ugohb.com/phpmail/sendmail.php"];
    
    //设备序列号
    NSString *deviceNumber = [[UIDevice currentDevice].identifierForVendor UUIDString];
    //手机型号
    NSString *phoneName = [[UIDevice currentDevice] model];
    
    NSString *mynumber = [NSString stringWithFormat:@"%@:%@",phoneName,deviceNumber];
    
    
    NSString *data = [NSString stringWithFormat:@"mynumber=%@&tuijianren=%@",mynumber,self.phoneNumber.text];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [data dataUsingEncoding:NSUTF8StringEncoding];
    
    //连接，异步
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
    }];
    
    
    
}
@end





















