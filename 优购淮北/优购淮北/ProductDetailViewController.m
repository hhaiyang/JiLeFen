//
//  ProductDetailViewController.m
//  优购淮北
//
//  Created by 李峰峰 on 15/8/20.
//  Copyright (c) 2015年 李峰峰. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "MBProgressHUD+MJ.h"

@interface ProductDetailViewController ()<UIWebViewDelegate>

@property(nonatomic,weak)UIWebView *productdetailWebView;
@property(strong,nonatomic)MBProgressHUD *HUD;

@property (strong, nonatomic) IBOutlet UIView *productdetailView;
- (IBAction)backButtonClick;
@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(void)viewDidAppear:(BOOL)animated{
    UIWebView *productdetailWebView = [[UIWebView alloc]init];
    productdetailWebView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.productdetailView.frame.size.height);
    [self.productdetailView addSubview:productdetailWebView];
    self.productdetailWebView = productdetailWebView;
    
    productdetailWebView.delegate = self;
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.labelText = @"正在加载";
    
    self.HUD = HUD;
    [HUD show:YES];
    NSLog(@"url = %@", self.productUrl);
    NSURL *url = [NSURL URLWithString:self.productUrl];
//    NSURL *url2 = [[NSBundle mainBundle] URLForResource:@"testindex.html" withExtension:nil];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [productdetailWebView loadRequest:request];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.HUD hide:YES];
}


#pragma mark-UIWebViewDelegate的代理方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    [self.HUD show:YES];
    
    return true;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.HUD hide:YES];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.HUD hide:YES];
    [MBProgressHUD showError:@"没有网络连接"];
}



- (IBAction)backButtonClick {
    if (self.productdetailWebView.canGoBack) {
        [self.productdetailWebView goBack];
    }else{
    
        if ([self.delegate respondsToSelector:@selector(productBackButtonClick)]) {
            [self.delegate productBackButtonClick];
        }
    }
}
@end
