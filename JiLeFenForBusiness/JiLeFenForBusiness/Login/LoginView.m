//
//  LoginView.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = LOGIN_BACKGROUND_COLOR;
        
        UIImageView *logoImageView = [UIImageView new];
        logoImageView.layer.cornerRadius = 5;
        logoImageView.backgroundColor = [UIColor whiteColor];
        logoImageView.frame = CGRectMake((self.width-200)/2, 84, 200, 50);
        logoImageView.image = [UIImage imageNamed:@"标志"];
        [self addSubview:logoImageView];
        
        UIImageView *inputBackgroundImageView = [UIImageView new];
        inputBackgroundImageView.userInteractionEnabled = YES;
        UIImage *backgroundImage = [UIImage imageNamed:@"登陆页面1"];
        CGFloat width = self.width - 40;
        CGFloat height = backgroundImage.size.height/backgroundImage.size.width*width;
        inputBackgroundImageView.image = backgroundImage;
        inputBackgroundImageView.frame = CGRectMake(20, logoImageView.y+logoImageView.height+5, width, height);
        [self addSubview:inputBackgroundImageView];
        
        UITextField *passwordTextField = [UITextField new];
        passwordTextField.secureTextEntry = YES;
        self.passwordTextField = passwordTextField;
        passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
        passwordTextField.placeholder = @"密码";
        passwordTextField.frame = CGRectMake(30, 0, inputBackgroundImageView.width-60, 40);
        CGPoint center = passwordTextField.center;
        center.y = inputBackgroundImageView.height/2;
        passwordTextField.center = center;
        [inputBackgroundImageView addSubview:passwordTextField];
        
        UITextField *userNameTextField = [UITextField new];
        self.userNameTextField = userNameTextField;
        userNameTextField.borderStyle = UITextBorderStyleRoundedRect;
        userNameTextField.placeholder = @"账号";
        userNameTextField.frame = CGRectMake(30, passwordTextField.y-50, inputBackgroundImageView.width-60, 40);
        [inputBackgroundImageView addSubview:userNameTextField];
        
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.loginButton = loginButton;
        UIImage *loginImage = [UIImage imageNamed:@"登陆按钮"];
        height = 55;
        width = loginImage.size.width/loginImage.size.height*height;
        [loginButton setBackgroundImage:loginImage forState:UIControlStateNormal];
        [loginButton setBackgroundImage:loginImage forState:UIControlStateHighlighted];
        loginButton.frame = CGRectMake((inputBackgroundImageView.width-width)/2, passwordTextField.y+passwordTextField.height+20, width, height);
        [inputBackgroundImageView addSubview:loginButton];
        
        UIButton *gotoRegisterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.gotoRegisterButton = gotoRegisterButton;
        UIImage *registerImage = [UIImage imageNamed:@"注册按钮"];
        height = 55;
        width = registerImage.size.width/registerImage.size.height*height;
        [gotoRegisterButton setBackgroundImage:registerImage forState:UIControlStateNormal];
        gotoRegisterButton.frame = CGRectMake((self.width-width)/2, inputBackgroundImageView.y+inputBackgroundImageView.height, width, height);
        [self addSubview:gotoRegisterButton];
        
        
    }
    return self;
}

@end
