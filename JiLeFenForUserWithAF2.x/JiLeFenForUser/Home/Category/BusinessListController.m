//
//  AllCategoryController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BusinessListController.h"
#import "CategoryCell.h"
#import "BusinessController.h"
#import "Commbox.h"
#import "Cate.h"

@interface BusinessListController ()
@end

@implementation BusinessListController
- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回按钮" height:30];
    self.title = self.cate.name;
    //根据传过来的分类信息添加web view加载商家列表
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.ugohb.com/wap/catelist.php?id=%@", self.cate.ID]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    
    
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
