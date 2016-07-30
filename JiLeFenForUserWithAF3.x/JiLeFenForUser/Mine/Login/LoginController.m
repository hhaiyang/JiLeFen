//
//  LoginController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "LoginController.h"
#import "RegisterController.h"
#import "RecordPasswordButton.h"
@interface LoginController () <UITextFieldDelegate>
@property (strong, nonatomic) UITextField *phoneTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) RecordPasswordButton *recordPasswordButton;
@end

@implementation LoginController
- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(backAction:) imageName:@"返回小图标-白色" height:30];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIImageView *backgroundImageView = [UIImageView new];
    backgroundImageView.userInteractionEnabled = YES;
    backgroundImageView.image = [UIImage imageNamed:@"Loginbackground"];
    backgroundImageView.frame = self.view.bounds;
    self.backgroundImageView = backgroundImageView;
    [self.view addSubview:backgroundImageView];
    
    UIImageView *inputImageView = nil;
    CGFloat inputWidth = backgroundImageView.width-60;
    CGFloat inputHeight = 45;
    NSArray *placeholds = @[@"手机号", @"密码"];
    NSArray *images = @[@"输入账号-小人物", @"输入密码-锁"];
    for (int index = 0; index < 2; index++) {
        inputImageView = [UIImageView new];
        inputImageView.userInteractionEnabled = YES;
        inputImageView.frame = CGRectMake(30, 33+index*(inputHeight+15), inputWidth, inputHeight);
        inputImageView.image = [UIImage imageNamed:@"白色半透明背景"];
        [backgroundImageView addSubview:inputImageView];
        
        UIImageView *iconImageView = [UIImageView new];
        UIImage *iconImage = [UIImage imageNamed:images[index]];
        CGFloat iconWidth = 30;
        CGFloat iconHeight = iconImage.size.height/iconImage.size.width*iconWidth;
        iconImageView.frame = CGRectMake(10, (inputImageView.height-iconHeight)/2, iconWidth, iconHeight);
        iconImageView.image = iconImage;
        [inputImageView addSubview:iconImageView];
        
        UITextField *textField = [UITextField new];
        NSAttributedString *placehold = [[NSAttributedString alloc] initWithString:placeholds[index] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        textField.attributedPlaceholder = placehold;
        textField.frame = CGRectMake(iconImageView.x+iconImageView.width+10, 0, inputImageView.width-iconImageView.width-30, inputImageView.height);
        [inputImageView addSubview:textField];
        if (index == 0) {
            self.phoneTextField = textField;
            textField.delegate = self;
        } else {
            self.passwordTextField = textField;
            textField.secureTextEntry = YES;
        }
        
        
    }
    
    RecordPasswordButton *recordPasswordButton = [[RecordPasswordButton alloc] initWithFrame:CGRectMake(inputImageView.x, inputImageView.y+inputImageView.height+7, 110, 30)];
    _recordPasswordButton = recordPasswordButton;
    [recordPasswordButton addTarget:self action:@selector(recordPassword:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundImageView addSubview:recordPasswordButton];
    
    /*
    UIButton *forgotPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *forgotImage = [UIImage imageNamed:@"忘记密码小图标"];
    CGFloat forgotHeight = 30;
    CGFloat forgotWidth = forgotImage.size.width/forgotImage.size.height*forgotHeight;
    forgotPasswordButton.frame = CGRectMake(inputImageView.x+inputImageView.width-forgotWidth, recordPasswordButton.y, forgotWidth, forgotHeight);
    [forgotPasswordButton setBackgroundImage:forgotImage forState:UIControlStateNormal];
    [forgotPasswordButton addTarget:self action:@selector(forgetPassword:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundImageView addSubview:forgotPasswordButton];
     */
    
    UIButton *button = nil;
    CGFloat buttonHeight = 47;
    images = @[@"立即登录按钮", @"快速注册按钮"];
    for (int index = 0; index < 2; index++) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:images[index]];
        CGFloat buttonWidth = image.size.width/image.size.height*buttonHeight;
        button.frame = CGRectMake((backgroundImageView.width-buttonWidth)/2, recordPasswordButton.y+recordPasswordButton.height+45+index*(buttonHeight+20), buttonWidth, buttonHeight);
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [backgroundImageView addSubview:button];
        if (index == 0) {
            [button addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [button addTarget:self action:@selector(registerAccount:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Loginbackground"] forBarMetrics:UIBarMetricsDefault];

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
     [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
}

- (void)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)forgetPassword:(UIButton *)sender {
    TEST_LOG(@"忘记密码");
    
}
- (void)login:(id)sender {
    [self.view endEditing:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *username = self.phoneTextField.text;
    NSString *password = self.passwordTextField.text;
    if (username.length <= 0) {
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请输入手机号";
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
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"userid"] = username;
    para[@"password"] = password;
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=login" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TEST_LOG(@"res = %@", responseObject);
        int status = [responseObject[@"status"] intValue];
         hud.mode = MBProgressHUDModeText;
        if (status == 0) {
            hud.label.text = @"登录失败";
            [hud hideAnimated:YES afterDelay:1.5];
            return ;
        }
      
        [hud hideAnimated:YES];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *password = [ud objectForKey:_phoneTextField.text];
        if (_recordPasswordButton.selected) {
            if (!password) {
                [ud setObject:_passwordTextField.text forKey:_phoneTextField.text];
            }
            
        } else {
            if (password) {
                [ud removeObjectForKey:_phoneTextField.text];
            }
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        TEST_LOG(@"error = %@", error);
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"登录失败";
        [hud hideAnimated:YES afterDelay:1.5];
    }];

}
- (void)registerAccount:(id)sender {
    TEST_LOG(@"注册");
    RegisterController *registerController = [RegisterController new];
    [self.navigationController pushViewController:registerController animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:textField.text];
    if (password) {
        self.passwordTextField.text = password;
        self.recordPasswordButton.selected = YES;
        self.recordPasswordButton.recordPasswordImageView.image = [UIImage imageNamed:@"记住密码按钮"];
    }
    return YES;
}

@end
