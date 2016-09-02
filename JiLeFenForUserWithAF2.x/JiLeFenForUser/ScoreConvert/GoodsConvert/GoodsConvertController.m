//
//  GoodConvertDetailController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/4.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "GoodsConvertController.h"

@interface GoodsConvertController ()
@property (nonatomic, strong) UIScrollView *contentScrollView;

@end

@implementation GoodsConvertController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物品兑换";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(backAction) imageName:@"返回小图标-红色" height:30];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //请求数据
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *para = [NSMutableDictionary new];
    
    
    _contentScrollView = [UIScrollView new];
    _contentScrollView.frame = CGRectMake(0, 64, self.view.width, self.view.height-64-49);
    [self.view addSubview:_contentScrollView];
    
    
    
}
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
