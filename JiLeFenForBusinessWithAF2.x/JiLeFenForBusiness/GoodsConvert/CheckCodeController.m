//
//  CheckCodeController.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CheckCodeController.h"
#import "GoodsInfoController.h"

@interface CheckCodeController ()
@property (nonatomic, strong) UITextField *textField;

@end

@implementation CheckCodeController
- (UITextField *)textField {
    if (_textField) {
        return _textField;
    }
    _textField = [ViewUtil textFieldWithOrigin:CGPointMake(30, 60) width:self.view.width-60 placehold:@"请输入兑换码"];
    return _textField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.textField];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(checkCode) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(60, self.textField.y+self.textField.height+30, self.view.width-120, 50);
    button.layer.cornerRadius = 5;
    [button setTitle:@"验证兑换码" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)checkCode {
    [self.view endEditing:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (self.textField.text.length <= 0) {
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请先输入兑换码";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    hud.label.text = @"验证中，请稍候";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
//    para[@"userid"] = [User currentUser].ID;
    para[@"code"] = self.textField.text;
    para[@"userid"] = @"18158912554";
    __weak typeof(self) weakSelf = self;
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=checkcodes" parameters:para constructingBodyWithBlock:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TEST_LOG(@"res = %@", responseObject);
        int status = [responseObject[@"status"] intValue];
        if (status == 0) {
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"没有该兑换码信息";
            [hud hideAnimated:YES afterDelay:1.5];
            return ;
        }
        hud.label.text = @"获取商品信息中，请稍候";
        [para removeAllObjects];
        para[@"code"] = @"CSSP2015111555525549";
        [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=getcodesgood" parameters:para success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            TEST_LOG(@"res = %@", responseObject);
//            int status = [responseObject[@"status"] intValue];
//            if (status == 0) {
//                hud.mode = MBProgressHUDModeText;
//                hud.label.text = @"获取商品信息失败";
//                [hud hideAnimated:YES afterDelay:1.5];
//                return ;
//            }
            [hud hideAnimated:YES];
            [weakSelf toGoodsInfoVC];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            TEST_LOG(@"error = %@", error);
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"获取商品信息失败";
            [hud hideAnimated:YES afterDelay:1.5];
            
        }];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        TEST_LOG(@"error = %@", error);
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"验证失败";
        [hud hideAnimated:YES afterDelay:1.5];

        
        
    }];
}
- (void)toGoodsInfoVC {
    GoodsInfoController *goodsInfo = [GoodsInfoController new];
    [self.navigationController pushViewController:goodsInfo animated:YES];
    
}

@end
