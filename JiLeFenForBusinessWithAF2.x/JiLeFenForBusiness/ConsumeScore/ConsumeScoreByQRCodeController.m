//
//  ConsumeScoreByQRCodeController.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/6/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ConsumeScoreByQRCodeController.h"
#import "ScanQRCodeController.h"

@interface ConsumeScoreByQRCodeController ()
@property (nonatomic, strong) UITextField *scoreTextField;
@end

@implementation ConsumeScoreByQRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消费积分";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(toForwardVC) imageName:@"二级页面返回小图标" height:30];
    
    UITextField *scoreTextField = [ViewUtil textFieldWithOrigin:CGPointMake(30, 120) width:self.view.width-60 placehold:@"请输入积分数额"];
    scoreTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.scoreTextField = scoreTextField;
    [self.view addSubview:scoreTextField];
    
    CGFloat width = 100;
    CGFloat height = 30;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(scanQRCode) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake((self.view.width-width)/2, scoreTextField.y+scoreTextField.height+100, width, height);
    button.layer.cornerRadius = 5;
    [button setTitle:@"开启扫码" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = kRGBColor(254, 119, 162);
    [self.view addSubview:button];

    
}
- (void)toForwardVC {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)scanQRCode {
    [self.view endEditing:YES];
    if (self.scoreTextField.text.length <= 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请先输入积分数额";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    if (![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"照相机不可用";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    ScanQRCodeController *scanQRCode = [ScanQRCodeController new];
    [self.navigationController pushViewController:scanQRCode animated:YES];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
