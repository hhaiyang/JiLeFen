//
//  AddScoreController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AddScoreController.h"
#import "QRCodeGenerator.h"



@interface AddScoreController ()

@end

@implementation AddScoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"增加积分";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回小图标-红色" height:30];
    
    //提示标签
    UILabel *label = [UILabel new];
    label.numberOfLines = 2;
    label.frame = CGRectMake((self.view.width-150)/2, 64+30, 150, 50);
    label.text = @"到店消费积分时请让商家扫描下方二维码";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:label];
    
    //二维码
    UIImageView *qrcodeImageView = [UIImageView new];
    CGFloat x = 35;
    CGFloat width = self.view.width-x*2;
    qrcodeImageView.frame = CGRectMake(x, label.y+label.height+10, width, width);
    qrcodeImageView.image = [QRCodeGenerator qrImageForString:@"huanghaiyang" imageSize:qrcodeImageView.size.width];
    [self.view addSubview:qrcodeImageView];

}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
