//
//  VerifySuccessController.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/6/4.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "VerifySuccessController.h"

@interface VerifySuccessController ()

@end

@implementation VerifySuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"验证成功";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(toForwardVC) imageName:@"二级页面返回小图标" height:30];
    UIImageView *imageView = [ViewUtil successImageViewWithPosition:CGPointMake(0, 150) andHeight:100];
    CGPoint center = imageView.center;
    center.x = self.view.width/2;
    imageView.center = center;
    [self.view addSubview:imageView];
    
    UILabel *label = [UILabel new];
    label.text = @"验证成功！";
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(10, imageView.y+imageView.height+30, self.view.width-20, 21);
    [self.view addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((self.view.width-100)/2, label.y+label.height+50, 100, 30);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"关闭" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 3;
    [button addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}

- (void)toForwardVC {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)closeAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
