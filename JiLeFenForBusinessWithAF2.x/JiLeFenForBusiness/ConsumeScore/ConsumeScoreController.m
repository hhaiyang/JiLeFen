//
//  ConsumeScoreController.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/31.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ConsumeScoreController.h"
#import "ConsumeScoreByUserNameController.h"
#import "ConsumeScoreByQRCodeController.h"

@interface ConsumeScoreController ()

@end

@implementation ConsumeScoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"消费积分";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(toForwardVC) imageName:@"二级页面返回小图标" height:30];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [UILabel new];
    label.text = @"请选择积分方式：";
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(10, 150, self.view.width-20, 21);
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label];
    
    CGFloat width = (self.view.width-60)/2;
    CGFloat height = 100;
    UIView *view = nil;
    UILabel *textLabel = nil;
    UIButton *button = nil;
    NSArray *titles = @[@"扫描二维码", @"用户名称"];
    NSArray *images = @[@"首页-查看二维码小图标", @"首页-查看代码小图标"];
    UIImage *image = nil;
    for (int index = 0; index < 2; index++) {
        view = [UIView new];
        view.frame = CGRectMake(index*width+30, label.y+label.height+20, width, height);
        [self.view addSubview:view];
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        image = [UIImage imageNamed:images[index]];
        CGFloat buttonHeight = height-25;
        CGFloat buttonWidth = image.size.width/image.size.height*buttonHeight;
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.frame = CGRectMake((width-buttonWidth)/2, 0, buttonWidth, buttonHeight);
        [view addSubview:button];
        if (index == 0) {
            [button addTarget:self action:@selector(consumeScoreByQRCode) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [button addTarget:self action:@selector(consumeScoreByUserName) forControlEvents:UIControlEventTouchUpInside];
        }
        
        textLabel = [UILabel new];
        textLabel.textColor = [UIColor grayColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = [UIFont systemFontOfSize:14];
        textLabel.text = titles[index];
        CGFloat labelWidth = width-20;
        CGFloat labelHeight = 21;
        textLabel.frame = CGRectMake(10, height-21, labelWidth, labelHeight);
        [view addSubview:textLabel];
        
    }
    
    
    
}
- (void)consumeScoreByQRCode {
    ConsumeScoreByQRCodeController *qrcode = [ConsumeScoreByQRCodeController new];
    [self.navigationController pushViewController:qrcode animated:YES];
    
}
- (void)consumeScoreByUserName {
    ConsumeScoreByUserNameController *userName = [ConsumeScoreByUserNameController new];
    [self.navigationController pushViewController:userName animated:YES];
    
}
- (void)toForwardVC {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
