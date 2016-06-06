//
//  LoginView.h
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView
@property (nonatomic, strong) UITextField *userNameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *gotoRegisterButton;
- (instancetype)initWithFrame:(CGRect)frame;
@end
