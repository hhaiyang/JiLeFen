//
//  LoginController.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "LoginController.h"
#import "LoginView.h"
#import "RegisterController.h"
#import "HomeController.h"
#import "User.h"

@interface LoginController () <UITextFieldDelegate>
@property (nonatomic, strong) LoginView *loginView;
@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    LoginView *loginView = [[LoginView alloc] initWithFrame:self.view.bounds];
    loginView.userNameTextField.delegate = self;
    [loginView.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [loginView.gotoRegisterButton addTarget:self action:@selector(toRegisterVC) forControlEvents:UIControlEventTouchUpInside];
    [loginView.recordPasswordButton addTarget:self action:@selector(recordPassword:) forControlEvents:UIControlEventTouchUpInside];
    self.loginView = loginView;
    [self.view addSubview:loginView];
    self.title = @"登陆";
    
    [self addKeyboardNotification];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)addKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWillShow:(NSNotification *)noti {
    NSDictionary *userInfo = noti.userInfo;
    CGRect keyboardEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIViewAnimationOptions option = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect frame = [self.loginView.passwordTextField.superview convertRect:self.loginView.passwordTextField.frame toView:self.view];
    CGFloat y = frame.origin.y + frame.size.height;
    if (y > keyboardEndFrame.origin.y) {
        CGRect loginViewFrame = self.loginView.frame;
        loginViewFrame.origin.y = loginViewFrame.origin.y - (y-keyboardEndFrame.origin.y);
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:duration delay:0 options:option animations:^{
            weakSelf.loginView.frame = loginViewFrame;
        } completion:nil];
    }
    
}
- (void)keyboardWillHide:(NSNotification *)noti {
      NSDictionary *userInfo = noti.userInfo;
    UIViewAnimationOptions option = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        weakSelf.loginView.frame = self.view.bounds;
    } completion:nil];
}
- (void)login {
    
    [self hideKeyboard];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *username = self.loginView.userNameTextField.text;
    NSString *password = self.loginView.passwordTextField.text;
    if (username.length <= 0) {
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请输入用户名";
        [hud hideAnimated:YES afterDelay:0.5];
        return;
    }
    if (password.length <= 0) {
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请输入密码";
        [hud hideAnimated:YES afterDelay:0.5];
        return;
    }
    hud.label.text = @"登录中";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    __weak typeof(self) weakSelf = self;
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=login" parameters:@{@"userid":username, @"password":password} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TEST_LOG(@"res = %@", responseObject);
        int status = [responseObject[@"status"] intValue];
        if (status == 0) {
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"登录失败";
            [hud hideAnimated:YES afterDelay:0.5];
            return ;
        }
        //跳到主界面
        [User currentUser].ID = responseObject[@"userid"];
        [hud hideAnimated:YES];
        [weakSelf toHomeVC];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        TEST_LOG(@"error = %@", error);
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"登录失败";
        [hud hideAnimated:YES afterDelay:0.5];
    }];
    
}
- (void)toRegisterVC {
    RegisterController *registerVC = [RegisterController new];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}
- (void)hideKeyboard {
    [self.view endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hideKeyboard];
}
- (void)toHomeVC {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *password = [ud objectForKey:self.loginView.userNameTextField.text];
    if (self.loginView.recordPasswordButton.selected) {
        if (!password) {
            [ud setObject:self.loginView.passwordTextField.text forKey:self.loginView.userNameTextField.text];
        }
        
    } else {
        if (password) {
            [ud removeObjectForKey:self.loginView.userNameTextField.text];
        }
        
    }
    HomeController *home = [HomeController new];
    UINavigationController *homeNavi = [[UINavigationController alloc] initWithRootViewController:home];
    kWindow.rootViewController = homeNavi;
    
}
- (void)recordPassword:(UIButton *)sender {
    RecordPasswordButton *button = (RecordPasswordButton *)sender;
    button.selected = !button.selected;
    if (button.selected) {
        button.recordPasswordImageView.image = [UIImage imageNamed:@"记住密码按钮"];
        
    } else {
        button.recordPasswordImageView.image = [UIImage imageNamed:@"记住密码按钮-待选"];
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:textField.text];
    if (password) {
        self.loginView.passwordTextField.text = password;
        self.loginView.recordPasswordButton.selected = YES;
        self.loginView.recordPasswordButton.recordPasswordImageView.image = [UIImage imageNamed:@"记住密码按钮"];
    }
    return YES;
}
@end
