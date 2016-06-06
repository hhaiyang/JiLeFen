//
//  MerchantController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MerchantController.h"

@interface MerchantController ()

@end

@implementation MerchantController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回按钮" height:30];
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
