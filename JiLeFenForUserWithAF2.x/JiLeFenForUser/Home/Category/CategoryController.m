//
//  AllCategoryController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CategoryController.h"
#import "CategoryCell.h"
#import "BusinessController.h"
#import "Commbox.h"

@interface CategoryController ()

@end

@implementation CategoryController
- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回按钮" height:30];
    
    if (self.businessType != BusinessTypeAll) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:webView];
        NSString *urlStr = nil;
        if (self.businessType == BusinessTypeDiscount) {
            urlStr = @"http://www.ugohb.com/client/diszhe.php?did=1";
        } else if (self.businessType == BusinessTypeSupermarket) {
            urlStr = @"http://www.ugohb.com/client/catelist.php?id=3";
        } else if (self.businessType == BusinessTypeProperty) {
            urlStr = @"url = http://www.ugohb.com/client/catelist.php?id=4";
        } else if (self.businessType == BusinessTypeFurniture) {
            urlStr = @"url = http://www.ugohb.com/client/catelist.php?id=196";
        } else if (self.businessType == BusinessTypeClothes) {
            urlStr = @"url = http://www.ugohb.com/client/catelist2.php?id=2";
        } else if (self.businessType == BusinessTypeMaterial) {
            urlStr = @"url = http://www.ugohb.com/client/catelist2.php?id=197";
        }
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
    
    }
    
    
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
