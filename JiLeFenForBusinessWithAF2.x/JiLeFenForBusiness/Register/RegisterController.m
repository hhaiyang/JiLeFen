//
//  RegisterController.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "RegisterController.h"

@interface RegisterController ()

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = REGISTER_BACKGROUND_COLOR;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(goBack) imageName:@"二级页面返回小图标" height:20];
    
    UILabel *messageLabel = [UILabel new];
    messageLabel.font = [UIFont systemFontOfSize:14];
    messageLabel.text = @"加入我们请联系客服登记资料、拍照！";
    messageLabel.frame = CGRectMake(10, (self.view.height-21)/2, self.view.width-20, 21);
    messageLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:messageLabel];
    
    UILabel *hintLabel = [UILabel new];
    hintLabel.font = messageLabel.font;
    hintLabel.textAlignment = NSTextAlignmentCenter;
    hintLabel.text = @"温馨提示：";
    hintLabel.frame = CGRectMake(10, messageLabel.y-10-messageLabel.height, self.view.width-20, 21);
    [self.view addSubview:hintLabel];
    
    UILabel *telLabel = [UILabel new];
    telLabel.text = @"4008-916-128";
    telLabel.textAlignment = NSTextAlignmentCenter;
    telLabel.font = [UIFont systemFontOfSize:20];
    telLabel.frame = CGRectMake(10, messageLabel.y+messageLabel.height+10, self.view.width-20, 21);
    [self.view addSubview:telLabel];
    
}
- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
