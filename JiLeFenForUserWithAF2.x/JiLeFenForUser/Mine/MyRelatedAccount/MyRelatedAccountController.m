//
//  MyRelatedAccountController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyRelatedAccountController.h"
#import "RelatedAccountSuccessController.h"
#import "IntroductionView.h"
#import "AccountValidate.h"

@interface MyRelatedAccountController ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *verifyCodeTextField;
@property (nonatomic, strong) UILabel *countDownLabel;
@property (nonatomic, strong) UIButton *getVerifyCodeButton;
@property (nonatomic, assign) int count;
@property (nonatomic, strong) NSTimer *countDownTimer;

@end

@implementation MyRelatedAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关联账号";
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回小图标-红色" height:30];
    
    _contentView = [UIView new];
    _contentView.frame = CGRectMake(0, 64, self.view.width, self.view.height-64);
    [self.view addSubview:_contentView];
    
    UILabel *hintLabel = [UILabel new];
    hintLabel.backgroundColor = kRGBColor(249, 249, 249);
    hintLabel.text = @"请输入要关联账号的手机号码（已注册用户），以及TA接受到的验证码";
    hintLabel.font = [UIFont systemFontOfSize:10];
    hintLabel.frame = CGRectMake(0, 0, _contentView.width, 30);
    hintLabel.textAlignment = NSTextAlignmentCenter;
    hintLabel.textColor = kRGBColor(178, 178, 178);
    [_contentView addSubview:hintLabel];
    
    UIImageView *imageView = nil;
    NSArray *placeholds = @[@"请输入要关联的账户", @"请输入验证码"];
    for (int index = 0; index < 2; index++) {
        imageView = [UIImageView new];
        imageView.userInteractionEnabled = YES;
        imageView.frame = CGRectMake(10, hintLabel.y+hintLabel.height+45+index*70, self.view.width-20, 45);
        imageView.image = [UIImage imageNamed:@"输入积分背景框"];
        [_contentView addSubview:imageView];
        
        UITextField *textField = [UITextField new];
        textField.placeholder = placeholds[index];
        textField.frame = CGRectMake(0, 0, imageView.width, imageView.height-10);
        [imageView addSubview:textField];
        if (index == 0) {
            _countDownLabel = [UILabel new];
            _countDownLabel.textColor = [UIColor redColor];
            _countDownLabel.textAlignment = NSTextAlignmentCenter;
            _countDownLabel.font = [UIFont systemFontOfSize:12];
            _countDownLabel.frame = CGRectMake(imageView.width-40, 0, 40, imageView.height-10);
            [imageView addSubview:_countDownLabel];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            _getVerifyCodeButton = button;
            CGFloat buttonHeight = imageView.height-15;
            UIImage *buttonImage = [UIImage imageNamed:@"获取验证码按钮"];
            CGFloat buttonWidth = buttonImage.size.width/buttonImage.size.height*buttonHeight;
            [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
            button.frame = CGRectMake(imageView.width-_countDownLabel.width-buttonWidth, 0, buttonWidth, buttonHeight);
            [button addTarget:self action:@selector(getVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
            
            textField.frame = CGRectMake(0, 0, imageView.width-_countDownLabel.width-button.width, imageView.height-10);
            _phoneTextField = textField;
            
        } else {
            _verifyCodeTextField = textField;
        }
        
    }
    
    UIButton *relateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat relateButtonHeight = 45;
    UIImage *relateImage = [UIImage imageNamed:@"确定"];
    CGFloat relateButtonWidth = relateImage.size.width/relateImage.size.height*relateButtonHeight;
    relateButton.frame = CGRectMake((_contentView.width-relateButtonWidth)/2, imageView.y+imageView.height+5, relateButtonWidth, relateButtonHeight);
    [relateButton setBackgroundImage:relateImage forState:UIControlStateNormal];
    [relateButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:relateButton];
    
    IntroductionView *introView = [[IntroductionView alloc] initWithFrame:CGRectMake(0, relateButton.y+relateButton.height+10, _contentView.width, _contentView.height-relateButton.y-relateButton.height-10)];
    introView.titleLabel.text = @"关联说明：";
    introView.detailTextView.text = @"1、关联的账户必须为已注册为积了分的用户；\n2、账户互相关联后，双方的积分汇总在一起，可以共同享受积分的所有优惠。例：您已积分1500分，关联的账号积分500分，可以兑换现金20元，额外可加兑换家政服务一次；\n3、解除关联后，已积的分全部为解除关联主动方所有。";
    [_contentView addSubview:introView];
    
    [self addKeyboardNotification];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)addKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWillShow:(NSNotification *)noti {
    CGRect rect = CGRectZero;
    if ([_phoneTextField isFirstResponder]) {
        rect = [_phoneTextField.superview.superview convertRect:_phoneTextField.superview.frame toView:kWindow];
        
    } else {
        rect = [_verifyCodeTextField.superview.superview convertRect:_verifyCodeTextField.superview.frame toView:kWindow];
    }
    CGRect keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
   
    if (rect.origin.y+rect.size.height > keyboardFrame.origin.y) {
         CGRect contentViewFrame = _contentView.frame;
        contentViewFrame.origin.y -= (rect.origin.y+rect.size.height-keyboardFrame.origin.y);
        NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        UIViewAnimationOptions option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
        [UIView animateWithDuration:duration delay:0 options:option animations:^{
            _contentView.frame = contentViewFrame;
            
        } completion:nil];

        
    }
    
}
- (void)keyboardWillHide:(NSNotification *)noti {
    CGRect contentViewFrame = _contentView.frame;
    contentViewFrame.origin.y = 64;
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        _contentView.frame = contentViewFrame;
        
    } completion:nil];
}
- (void)getVerifyCode:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    if (_phoneTextField.text.length <= 0) {
        hud.label.text = @"请输入要关联的账户";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    if (![AccountValidate validatePhone:_phoneTextField.text]) {
        hud.label.text = @"账户必须为手机号";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"获取中，请稍候";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"phone"] = _phoneTextField.text;
//    [manager POST:@"http://www.ugohb.com/app/sms.php" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        TEST_LOG(@"resp = %@", responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
////        hud.mode = MBProgressHUDModeText;
////        hud.label.text = @"获取失败";
////        [hud hideAnimated:YES afterDelay:1.5];
//        hud.mode = MBProgressHUDModeText;
//        hud.label.text = @"获取成功，请查收短信";
//        [hud hideAnimated:YES afterDelay:1.5];
//        _count = 59;
//        _countDownLabel.text = [NSString stringWithFormat:@"%d秒", _count];
//        _getVerifyCodeButton.enabled = NO;
//        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:weakSelf selector:@selector(countDown:) userInfo:nil repeats:YES];
//        
//        
//    }];
    [manager POST:@"http://www.ugohb.com/app/sms.php" parameters:para constructingBodyWithBlock:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"res = %@", responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@", error);
        
    }];
    
}
- (void)countDown:(NSTimer *)sender {
    _count--;
    if (_count <= 0) {
        [sender invalidate];
        _getVerifyCodeButton.enabled = YES;
        _countDownLabel.text = nil;
        return;
    }
    _countDownLabel.text = [NSString stringWithFormat:@"%d秒", _count];
}
- (void)back {
    [self.view endEditing:YES];
    if (_countDownTimer) {
        [_countDownTimer invalidate];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)confirm:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    if (_phoneTextField.text.length <= 0) {
        hud.label.text = @"请输入要关联的账户";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    if (![AccountValidate validatePhone:_phoneTextField.text]) {
        hud.label.text = @"账户必须为手机号";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    if (_verifyCodeTextField.text.length <= 0) {
        hud.label.text = @"请输入验证码";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"关联中，请稍候";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
        [weakSelf toRelatedSuccessVC];
    });
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)toRelatedSuccessVC {
    RelatedAccountSuccessController *successController = [RelatedAccountSuccessController new];
    [self.navigationController pushViewController:successController animated:YES];
}
@end
