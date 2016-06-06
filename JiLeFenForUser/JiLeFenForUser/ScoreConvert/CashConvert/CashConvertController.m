//
//  CashConvertController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CashConvertController.h"

@interface CashConvertController ()

@end

@implementation CashConvertController
/** 视图生命周期 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicSetup];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)basicSetup {
    self.title = @"现金兑换";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(backAction) imageName:@"返回小图标-红色" height:30];
   
}
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
