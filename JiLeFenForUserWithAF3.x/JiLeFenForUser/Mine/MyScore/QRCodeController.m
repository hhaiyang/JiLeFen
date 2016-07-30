//
//  QRCodeController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/6/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QRCodeController.h"
#import "QRCodeGenerator.h"

@interface QRCodeController ()

@end

@implementation QRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [UILabel new];
    label.numberOfLines = 2;
    label.frame = CGRectMake((self.view.width-150)/2, 30, 150, 50);
    label.text = @"到店消费积分时请让商家扫描下方二维码";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:label];
    
    UIImageView *qrcodeImageView = [UIImageView new];
    CGFloat width = self.view.width-100;
    qrcodeImageView.frame = CGRectMake(50, label.y+label.height+10, width, width);
    qrcodeImageView.image = [QRCodeGenerator qrImageForString:@"huanghaiyang" imageSize:qrcodeImageView.size.width];
    [self.view addSubview:qrcodeImageView];
    
    
    
}


@end
