//
//  GetBackPasswordController.m
//  JiLeFenForUser
//
//  Created by hhy on 16/9/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "GetBackPasswordController.h"

@interface GetBackPasswordController ()
@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *verifyCodeTextField;
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) UITextField *surePwdTextField;
@end

@implementation GetBackPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"找回密码";
      [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
     self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(toForwordController:) imageName:@"返回小图标-红色" height:30];
    
    UIView *view = nil;
    NSArray *placeholds = @[@"请输入用户名", @"请输入验证码", @"请输入密码", @"请确认新密码"];
    for (int i = 0; i < placeholds.count; i++) {
        view = [UIView new];
        view.frame = CGRectMake(0, 64+i*50, self.view.width, 50);
        [self.view addSubview:view];
        //分割线
        UIView *line = [UIView new];
        line.frame = CGRectMake(0, view.height-1, view.width, 1);
        line.backgroundColor = kRGBColor(243, 243, 243);
        [view addSubview:line];
        //输入框
        UITextField *textField = [UITextField new];
        textField.placeholder = placeholds[i];
        textField.frame = CGRectMake(20, 0, view.width-50-75, view.height);
        [view addSubview:textField];
        if (i == 0) {
            //获取验证码的按钮
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = kRGBColor(228, 51, 69);
            button.frame = CGRectMake(textField.x+textField.width+10, (view.height-25)/2, 75, 25);
            [button setTitle:@"获取验证码" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button addTarget:self action:@selector(getVerifyCode) forControlEvents:UIControlEventTouchUpInside];
            button.layer.cornerRadius = 7;
            [view addSubview:button];
            _usernameTextField = textField;
        } else if (i == 1) {
            _verifyCodeTextField = textField;
            
        } else if (i == 2) {
            _pwdTextField = textField;
            _pwdTextField.secureTextEntry = YES;
        } else {
            _surePwdTextField = textField;
            _surePwdTextField.secureTextEntry = YES;
            
        }
        
    }
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton addTarget:self action:@selector(getBackPwd) forControlEvents:UIControlEventTouchUpInside];
    submitButton.layer.cornerRadius = 5;
    submitButton.backgroundColor = kRGBColor(200, 55, 61);
    [submitButton setTitle:@"提  交" forState:UIControlStateNormal];
    submitButton.frame = CGRectMake(15, view.y+view.height+20, self.view.width-30, 40);
    [self.view addSubview:submitButton];
   
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

- (void)toForwordController:(id)sender {
    //收回键盘
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
//获取验证码
- (void)getVerifyCode {
    
}
//提交找回密码请求
- (void)getBackPwd {
    //收回键盘
    [self.view endEditing:YES];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
