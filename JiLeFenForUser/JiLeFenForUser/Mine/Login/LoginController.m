//
//  LoginController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "LoginController.h"
#import "RegisterController.h"
#import "LoginErrorPopView.h"
@interface LoginController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *psaawordTextField;
@property (weak, nonatomic) IBOutlet UIButton *rememberPasswordButton;
@property (nonatomic, strong) LoginErrorPopView *loginErrorPopView;
@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicSetup];
    [self initUI];
}
- (void)basicSetup {
    self.title = @"登录";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(backAction:) imageName:@"返回小图标-白色" height:30];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
   
    
    
}
- (void)initUI {
    [self.rememberPasswordButton setImage:[UIImage imageNamed:@"记住密码按钮-待选"] forState:UIControlStateNormal];
    [self.rememberPasswordButton setImage:[UIImage imageNamed:@"记住密码按钮"] forState:UIControlStateSelected];
}

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)rememberPassword:(UIButton *)sender {
    TEST_LOG(@"记住密码");
    sender.selected = !sender.selected;
}
- (IBAction)forgetPassword:(UIButton *)sender {
    TEST_LOG(@"忘记密码");
    
}
- (IBAction)login:(id)sender {
    TEST_LOG(@"登录");
    LoginErrorPopView *view = [LoginErrorPopView loginErrorPopView];
    self.loginErrorPopView = view;
    [view.registerButton addTarget:self action:@selector(registerNow) forControlEvents:UIControlEventTouchUpInside];
    view.frame = kScreenBounds;
    [kWindow addSubview:view];
}
- (IBAction)registerAccount:(id)sender {
    TEST_LOG(@"注册");
    RegisterController *registerController = [RegisterController new];
    [self.navigationController pushViewController:registerController animated:YES];
}
- (void)registerNow {
    [self.loginErrorPopView removeFromSuperview];
    self.loginErrorPopView = nil;
    [self registerAccount:nil];
}
@end
