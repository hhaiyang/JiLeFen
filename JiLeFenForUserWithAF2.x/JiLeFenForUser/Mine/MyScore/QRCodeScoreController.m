//
//  QRCodeScoreController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QRCodeScoreController.h"
#import "QRCodeScanViewController.h"

@interface QRCodeScoreController ()

@end

@implementation QRCodeScoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}
- (void)initUI {
    self.title = @"扫码积分";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回小图标-红色" height:30];
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)beginScanQRCode:(id)sender {
    TEST_LOG(@"开启扫码");
    QRCodeScanViewController *qrCodeScanController = [QRCodeScanViewController new];
    [self.navigationController pushViewController:qrCodeScanController animated:YES];
    
}
@end
