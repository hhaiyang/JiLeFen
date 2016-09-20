//
//  IntegralController.m
//  JiLeFenForUser
//
//  Created by hhy on 16/9/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "IntegralController.h"

@interface IntegralController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation IntegralController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回按钮" height:30];
    //创建一个web view加载数据
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64)];
    [self.view addSubview:_webView];
    NSURL *url = [NSURL URLWithString:@"http://www.ugohb.com/client/diszhe.php?did=1"];
    
    
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}
@end
