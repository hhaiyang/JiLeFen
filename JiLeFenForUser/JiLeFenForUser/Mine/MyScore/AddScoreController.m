//
//  AddScoreController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AddScoreController.h"
#import "QRCodeScoreController.h"
#import "QRCodeGenerator.h"

@interface AddScoreController ()
@property (weak, nonatomic) IBOutlet UIImageView *qrImageView;

@end

@implementation AddScoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}
- (void)initUI {
    self.title = @"增加积分";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回小图标-红色" height:30];
    
    UIImage *qrImage = [QRCodeGenerator qrImageForString:@"huanghaiyang" imageSize:self.qrImageView.bounds.size.width];
    self.qrImageView.image = qrImage;
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)scanQRCode:(id)sender {
    TEST_LOG(@"扫描二维码");
    QRCodeScoreController *qrCodeScoreController = [QRCodeScoreController new];
    [self.navigationController pushViewController:qrCodeScoreController animated:YES];
}
- (IBAction)scoreCode:(id)sender {
    TEST_LOG(@"积分代码");
}

@end
