//
//  ConsumeScoreSuccessController.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/6/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ConsumeScoreSuccessController.h"

@interface ConsumeScoreSuccessController ()

@end

@implementation ConsumeScoreSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消费积分";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(toForwardVC) imageName:@"二级页面返回小图标" height:30];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat height = 90;
    UIImageView *imageView = [ViewUtil successImageViewWithPosition:CGPointMake(0, 140) andHeight:height];
    CGPoint center = imageView.center;
    center.x = self.view.width/2;
    imageView.center = center;
    [self.view addSubview:imageView];
    
    UILabel *successLabel = [UILabel new];
    successLabel.text = @"积分成功";
    successLabel.textAlignment = NSTextAlignmentCenter;
    successLabel.frame = CGRectMake(10, imageView.y+imageView.height+10, self.view.width-20, 21);
    successLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:successLabel];
    
    UILabel *scoreLabel = [UILabel new];
    scoreLabel.textColor = kRGBColor(25, 184, 183);
    scoreLabel.font = [UIFont systemFontOfSize:20];
    scoreLabel.frame = CGRectMake(10, successLabel.y+successLabel.height+5, self.view.width-20, 21);
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.text = @"-229";
    [self.view addSubview:scoreLabel];
    
    CGFloat buttonWidth = 75;
    CGFloat buttonHeight = 30;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((self.view.width-buttonWidth)/2, scoreLabel.y+scoreLabel.height+10, buttonWidth, buttonHeight);
    button.layer.cornerRadius = 3;
    [button setTitle:@"关闭" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)toForwardVC {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)closeAction {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
