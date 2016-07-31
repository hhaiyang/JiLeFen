//
//  RegisterController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "RegisterController.h"
#import "AccountValidate.h"

@interface RegisterController () <UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *verifyCodeTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UITextField *surePasswordTextField;
@property (nonatomic, strong) UILabel *hintLabel;
@property (nonatomic, strong) UILabel *countDownLabel;
@property (nonatomic, strong) NSTimer *countDownTimer;
@property (nonatomic, assign) int count;
@property (nonatomic, strong) UIButton *getVerifyCodeButton;
@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.navigationItem.leftBarButtonItem = [ViewUtil whiteBackItemWithTarget:self action:@selector(toForwardVC)];
    
    UIImageView *backgroundImageView = [UIImageView new];
    backgroundImageView.userInteractionEnabled = YES;
    self.backgroundImageView = backgroundImageView;
    backgroundImageView.frame = self.view.bounds;
    backgroundImageView.image = [UIImage imageNamed:@"RegisterBackground"];
    [self.view addSubview:backgroundImageView];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"RegisterBackground"] forBarMetrics:UIBarMetricsDefault];
    
    UIImageView *imageView = nil;
    UIImage *image = [UIImage imageNamed:@"白色半透明背景"];
    CGFloat heigth = 45;
    CGFloat width = backgroundImageView.width-60;
    NSArray *images = @[@"输入账号-小人物", @"输入验证码小图标", @"输入密码-锁", @"输入密码-锁"];
    NSArray *placeholds = @[@"请输入您的手机号", @"请输入验证码", @"请输入您的密码", @"请再次确认密码"];
    for (int index = 0; index < 4; index++) {
        imageView = [UIImageView new];
        imageView.userInteractionEnabled = YES;
        imageView.image = image;
        imageView.frame = CGRectMake(30, 45+index*(heigth+20), width, heigth);
        [backgroundImageView addSubview:imageView];
        
        UIImageView *iconImageView = [UIImageView new];
        CGFloat iconWidth = 30;
        UIImage *icon = [UIImage imageNamed:images[index]];
        CGFloat iconHeight = icon.size.height/icon.size.width*iconWidth;
        iconImageView.image = icon;
        iconImageView.frame = CGRectMake(10, (imageView.height-iconHeight)/2, iconWidth, iconHeight);
        [imageView addSubview:iconImageView];
        
        UITextField *textField = [UITextField new];
        textField.delegate = self;
        textField.frame = CGRectMake(iconImageView.x+iconImageView.width+5, 0, imageView.width-20-iconImageView.width, imageView.height);
        NSAttributedString *attributePlacehold = [[NSAttributedString alloc] initWithString:placeholds[index] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        textField.attributedPlaceholder = attributePlacehold;
        [imageView addSubview:textField];
        
        if (index == 0) {
            self.phoneTextField = textField;
            
        } else if (index == 1) {
            self.verifyCodeTextField = textField;
            _countDownLabel = [UILabel new];
            _countDownLabel.frame = CGRectMake(imageView.width-33, 0, 30, imageView.height);
            _countDownLabel.textColor = [UIColor redColor];
            _countDownLabel.textAlignment = NSTextAlignmentCenter;
            _countDownLabel.font = [UIFont systemFontOfSize:11];
            [imageView addSubview:_countDownLabel];
            
            UIButton *verifyCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _getVerifyCodeButton = verifyCodeButton;
            UIImage *verifyCodeImage = [UIImage imageNamed:@"获取验证码按钮"];
            CGFloat verifyCodeHeight = imageView.height-20;
            CGFloat verifyCodeWidth = verifyCodeImage.size.width/verifyCodeImage.size.height*verifyCodeHeight;
            verifyCodeButton.frame = CGRectMake(_countDownLabel.x-1-verifyCodeWidth, (imageView.height-verifyCodeHeight)/2, verifyCodeWidth, verifyCodeHeight);
            [verifyCodeButton setBackgroundImage:verifyCodeImage forState:UIControlStateNormal];
            [verifyCodeButton addTarget:self action:@selector(getVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:verifyCodeButton];
            
            CGRect textFieldFrame = textField.frame;
            textFieldFrame.size.width = verifyCodeButton.x-20-iconImageView.width;
            textField.frame = textFieldFrame;
            
            _hintLabel = [UILabel new];
            _hintLabel.frame = CGRectMake(imageView.x, imageView.y+imageView.height+3, imageView.width, 12);
            _hintLabel.textAlignment = NSTextAlignmentRight;
            _hintLabel.textColor = [UIColor whiteColor];
            _hintLabel.font = [UIFont systemFontOfSize:10];
            [backgroundImageView addSubview:_hintLabel];
            
        } else if (index == 2) {
            self.passwordTextField = textField;
            textField.secureTextEntry = YES;
            
        } else {
            self.surePasswordTextField = textField;
            textField.secureTextEntry = YES;
        }
        
    }
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton addTarget:self action:@selector(beginRegister:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *registerImage = [UIImage imageNamed:@"开始注册按钮"];
    CGFloat registerButtonHeight = 45;
    CGFloat registerButtonWidth = registerImage.size.width/registerImage.size.height*registerButtonHeight;
    registerButton.frame = CGRectMake((backgroundImageView.width-registerButtonWidth)/2, imageView.y+imageView.height+25, registerButtonWidth, registerButtonHeight);
    [registerButton setBackgroundImage:registerImage forState:UIControlStateNormal];
    [backgroundImageView addSubview:registerButton];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (_countDownTimer) {
        [_countDownTimer invalidate];
    }

}

- (void)keyboardWillShow:(NSNotification *)noti {
    CGRect keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    CGRect rect = CGRectZero;
    if ([self.phoneTextField isFirstResponder]) {
        rect = [self.backgroundImageView convertRect:self.phoneTextField.superview.frame toView:kWindow];
        
    } else if ([self.verifyCodeTextField isFirstResponder]) {
        rect = [self.backgroundImageView convertRect:self.verifyCodeTextField.superview.frame toView:kWindow];
        
    } else if ([self.passwordTextField isFirstResponder]) {
        rect = [self.backgroundImageView convertRect:self.passwordTextField.superview.frame toView:kWindow];
    } else if ([self.surePasswordTextField isFirstResponder]) {
        rect = [self.backgroundImageView convertRect:self.surePasswordTextField.superview.frame toView:kWindow];
    }
    if (rect.origin.y+rect.size.height > keyboardFrame.origin.y) {
        CGRect backgroundImageViewFrame = self.backgroundImageView.frame;
        backgroundImageViewFrame.origin.y -= (rect.origin.y+rect.size.height-keyboardFrame.origin.y);
        [UIView animateWithDuration:duration delay:0 options:option animations:^{
            _backgroundImageView.frame = backgroundImageViewFrame;
            
        } completion:nil];
        
    }
  
    
    
}
- (void)keyboardWillHide:(NSNotification *)noti {
    __weak typeof(self) weakSelf = self;
    TEST_LOG(@"noti = %@", noti);
    CGRect backgroundImageViewFrame = self.backgroundImageView.frame;
    backgroundImageViewFrame = self.view.bounds;
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        weakSelf.backgroundImageView.frame = backgroundImageViewFrame;
    } completion:nil];
}
- (void)toForwardVC {
    [self.view endEditing:YES];
    if (_countDownTimer) {
        [_countDownTimer invalidate];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)beginRegister:(id)sender {
    TEST_LOG(@"开始注册");
    [self.view endEditing:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    if (![AccountValidate validatePhone:self.phoneTextField.text]) {
        hud.label.text = @"手机号格式不正确";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    if (self.verifyCodeTextField.text.length <= 0) {
        hud.label.text = @"请输入验证码";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    if (self.passwordTextField.text.length <= 0) {
        hud.label.text = @"请输入密码";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    if (self.surePasswordTextField.text.length <= 0) {
        hud.label.text = @"请输入确认密码";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    if (![self.passwordTextField.text isEqualToString:self.surePasswordTextField.text]) {
        hud.label.text = @"两次密码不一致";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"注册中，请稍候";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"phone"] = self.phoneTextField.text;
    para[@"password"] = self.passwordTextField.text;
    para[@"rands"] = self.verifyCodeTextField.text;
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=reg" parameters:para success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TEST_LOG(@"res = %@", responseObject);
        hud.mode = MBProgressHUDModeText;
        int status = [responseObject[@"status"] intValue];
        if (status == 1) {
            hud.label.text = @"注册成功";
            [hud hideAnimated:YES afterDelay:1.5];
            return ;
        }
        hud.label.text = @"注册失败";
        [hud hideAnimated:YES afterDelay:1.5];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        TEST_LOG(@"error = %@", error);
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"注册失败";
        [hud hideAnimated:YES afterDelay:1.5];
        
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)getVerifyCode:(UIButton *)sender {
    [self.view endEditing:YES];
    BOOL isPhone = [AccountValidate validatePhone:self.phoneTextField.text];
     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (isPhone == NO) {
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"手机号格式不正确";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    hud.label.text = @"获取中，请稍候";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"phone"] = self.phoneTextField.text;
    __weak typeof(self) weakSelf = self;
    [manager POST:@"http://www.ugohb.com/app/sms.php" parameters:para success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TEST_LOG(@"resp = %@", responseObject);
        int status = [responseObject[@"status"] intValue];
        hud.mode = MBProgressHUDModeText;
        if (status == 1) {
            hud.label.text = @"获取成功";
            [hud hideAnimated:YES afterDelay:1];
            _hintLabel.text = @"一分钟内不可频繁获取验证码";
            _count = 59;
            _countDownLabel.text = [NSString stringWithFormat:@"%d秒", _count];
            _getVerifyCodeButton.enabled = NO;
            _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:weakSelf selector:@selector(countDown:) userInfo:nil repeats:YES];
            return ;
        }
        if (status == 0) {
            hud.label.text = @"获取失败";
            [hud hideAnimated:YES afterDelay:1.5];
            return;
        }
        hud.label.text = @"该手机号已注册";
        [hud hideAnimated:YES afterDelay:1.5];
        
        

        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        TEST_LOG(@"error = %@", error);
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"获取失败";
        [hud hideAnimated:YES afterDelay:1.5];
        
    }];
    
    
}
- (void)countDown:(NSTimer *)timer {
    _count--;
    if (_count <= 0) {
        _countDownLabel.text = nil;
        _hintLabel.text = nil;
        _getVerifyCodeButton.enabled = YES;
        [timer invalidate];
        return;
    }
    _countDownLabel.text = [NSString stringWithFormat:@"%d秒", _count];
    
}

@end
