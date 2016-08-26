//
//  CashConvertController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CashConvertController.h"
#import "SelectBankController.h"
#import "CashConvertHintView.h"
#import "CashConvertCheckInfoView.h"
#import "CashConvertSuccessView.h"

@interface CashConvertController () <CashConvertHintViewDelegate, CashConvertCheckInfoViewDelegate>
@property (nonatomic, strong) UIView *contentView;
//现金积分
@property (nonatomic, strong) UILabel *cashScoreLabel;
@property (nonatomic, strong) UILabel *cashScoreStateLabel;
//积分兑现的金额
@property (nonatomic, strong) UITextField *cashTextField;
//收款银行卡持有人姓名
@property (nonatomic, strong) UITextField *nameTextField;
//收款银行卡预留手机号
@property (nonatomic, strong) UITextField *phoneTextField;
//收款银行卡号
@property (nonatomic, strong) UITextField *bankTextField;

@property (nonatomic, strong) CashConvertHintView *cashConvertHintView;
@property (nonatomic, strong) CashConvertCheckInfoView *cashConvertCheckInfoView;
@property (nonatomic, strong) CashConvertSuccessView *cashConvertSuccessView;

@end

@implementation CashConvertController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"现金兑换";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(backAction) imageName:@"返回小图标-红色" height:30];
    
    UIView *suspendView = [kWindow viewWithTag:1000];
    _contentView = [UIView new];
    _contentView.frame = CGRectMake(0, 64, self.view.width, self.view.height-64-49-suspendView.height);
    [self.view addSubview:_contentView];
    
    UIView *cashScoreView = [UIView new];
    cashScoreView.frame = CGRectMake(10, 15, _contentView.width-20, 45);
    cashScoreView.backgroundColor = kRGBColor(232, 232, 232);
    cashScoreView.layer.cornerRadius = 3;
    [_contentView addSubview:cashScoreView];
    
    UIView *line = [UIView new];
    line.backgroundColor = kRGBColor(214, 214, 214);
    line.frame = CGRectMake((cashScoreView.width-1)/2, 10, 1, cashScoreView.height-20);
    [cashScoreView addSubview:line];
    
    for (int index = 0; index < 2; index++) {
        UILabel *label = [UILabel new];
        label.frame = CGRectMake(cashScoreView.width/2*index, 0, cashScoreView.width/2, cashScoreView.height);
        label.textAlignment = NSTextAlignmentCenter;
        if (index == 0) {
            _cashScoreLabel = label;
            NSMutableAttributedString *str = [NSMutableAttributedString new];
            NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"现金积分 " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
            NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"369" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20], NSForegroundColorAttributeName:[UIColor redColor]}];
            [str appendAttributedString:str1];
            [str appendAttributedString:str2];
            label.attributedText = str;
            
        } else {
            _cashScoreStateLabel = label;
            NSMutableAttributedString *str = [NSMutableAttributedString new];
            NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"年底 " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
            NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"不清零" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor redColor]}];
            [str appendAttributedString:str1];
            [str appendAttributedString:str2];
            label.attributedText = str;
            
        }
        [cashScoreView addSubview:label];
    }
    
    UILabel *cashConvertLabel = [UILabel new];
    cashConvertLabel.text = @"积分兑现";
    cashConvertLabel.font = [UIFont systemFontOfSize:20];
    cashConvertLabel.frame = CGRectMake(15, cashScoreView.y+cashScoreView.height+10, _contentView.width-30, 21);
    [_contentView addSubview:cashConvertLabel];
    

    UIView *inputView = nil;
    NSArray *titles = @[@"金额", @"卡号", @"姓名", @"手机", @"银行"];
    NSArray *placeholds = @[@"请输入兑换金额（须为整数）", @"请输入收款银行卡号", @"请输入银行卡持有人姓名", @"请输入银行预留手机号"];
    for (int index = 0; index < 5; index++) {
        inputView = [UIView new];
        inputView.frame = CGRectMake(0, cashConvertLabel.y+cashConvertLabel.height+10+index*40, _contentView.width, 40);
        [_contentView addSubview:inputView];
        
        UIView *line = [UIView new];
        line.frame = CGRectMake(0, inputView.height-1, inputView.width, 1);
        line.backgroundColor = kRGBColor(232, 232, 232);
        if (index == 0) {
            line.backgroundColor = kRGBColor(247, 194, 200);
            line.frame = CGRectMake(0, inputView.height-2, inputView.width, 2);
            
        }
        [inputView addSubview:line];
        
        
        UILabel *label = [UILabel new];
        label.text = titles[index];
        label.frame = CGRectMake(15, 0, 45, inputView.height);
        [inputView addSubview:label];
        
        if (index == 4) {
            _bankLabel = [UILabel new];
            _bankLabel.text = @"点击选择银行卡开户行类型";
            _bankLabel.textColor = [UIColor lightGrayColor];
            _bankLabel.textAlignment = NSTextAlignmentRight;
            _bankLabel.frame = CGRectMake(label.x+label.width+10, 0, inputView.width-20-label.width-label.x-10, inputView.height);
            [inputView addSubview:_bankLabel];
            
            UITapGestureRecognizer *selectBankGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectBank)];
            [inputView addGestureRecognizer:selectBankGR];
            
        } else {
            UITextField *textField = [UITextField new];
            textField.placeholder = placeholds[index];
            textField.frame = CGRectMake(label.x+label.width, 0, inputView.width-30-label.width, inputView.height);
            [inputView addSubview:textField];
            if (index == 0) {
                _cashTextField = textField;
                textField.keyboardType = UIKeyboardTypeNumberPad;
            } else if (index == 1) {
                _nameTextField = textField;
            } else if (index == 2) {
                _phoneTextField = textField;
                textField.keyboardType = UIKeyboardTypeNumberPad;
            } else {
                _bankTextField = textField;
                textField.keyboardType = UIKeyboardTypeNumberPad;
            }

        }
        
        
        
    }
    
    //提交按钮
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.layer.cornerRadius = 5;
    submitButton.frame = CGRectMake((_contentView.width-70)/2, inputView.y+inputView.height+20, 70, 30);
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    submitButton.backgroundColor = kRGBColor(228, 51, 69);
    [submitButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:submitButton];
    [self addKeyboardNotification];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
  
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
    CGRect keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect rect = CGRectZero;
    if ([_cashTextField isFirstResponder]) {
        rect = [_contentView convertRect:_cashTextField.superview.frame toView:kWindow];
    } else if ([_nameTextField isFirstResponder]) {
        rect = [_contentView convertRect:_nameTextField.superview.frame toView:kWindow];
    } else if ([_phoneTextField isFirstResponder]) {
        rect = [_contentView convertRect:_phoneTextField.superview.frame toView:kWindow];
    } else if ([_bankTextField isFirstResponder]) {
        rect = [_contentView convertRect:_bankTextField.superview.frame toView:kWindow];
    }
    if (rect.origin.y+rect.size.height > keyboardFrame.origin.y) {
        CGRect contentViewFrame = _contentView.frame;
        contentViewFrame.origin.y -= (rect.origin.y+rect.size.height-keyboardFrame.origin.y);
        double duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        NSInteger option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
        [UIView animateWithDuration:duration delay:0 options:option animations:^{
            _contentView.frame = contentViewFrame;
        } completion:nil];
    }
    
    
}
- (void)keyboardWillHide:(NSNotification *)noti {
    CGRect contentViewFrame = _contentView.frame;
    contentViewFrame.origin.y = 64;
    double duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSInteger option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        _contentView.frame = contentViewFrame;
    } completion:nil];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)backAction {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
//提交
- (void)submit:(UIButton *)sender {
    [self.view endEditing:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
     hud.mode = MBProgressHUDModeText;
    if (_cashTextField.text.length <= 0) {
        hud.label.text = @"请输入兑换金额";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    if (_bankTextField.text.length <= 0) {
        hud.label.text = @"请输入收款银行卡号";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    if (_nameTextField.text.length <= 0) {
        hud.label.text = @"请输入银行卡持有人姓名";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    if (_phoneTextField.text.length <= 0) {
        hud.label.text = @"请输入银行预留手机号";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    if (_bankLabel.text.length <= 0) {
        hud.label.text = @"请选择银行卡类型";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    [hud hideAnimated:YES];
    _cashConvertHintView = [[CashConvertHintView alloc] init];
    _cashConvertHintView.delegate = self;
    [kWindow addSubview:_cashConvertHintView];
    
    
}
- (void)selectBank {
    [self.view endEditing:YES];
    SelectBankController *selectBank = [SelectBankController new];
    selectBank.cashConvertController = self;
    [self.navigationController pushViewController:selectBank animated:YES];
}

- (void)cashConvertHintView:(CashConvertHintView *)view didClickedCloseButton:(UIButton *)button {
    [_cashConvertHintView removeFromSuperview];

}
- (void)cashConvertHintView:(CashConvertHintView *)view didClickedBackButton:(UIButton *)button {
    [_cashConvertHintView removeFromSuperview];

    
}
- (void)cashConvertHintView:(CashConvertHintView *)view didClickedNextStepButton:(UIButton *)button {
    [_cashConvertHintView removeFromSuperview];
    _cashConvertCheckInfoView = [[CashConvertCheckInfoView alloc] init];
    _cashConvertCheckInfoView.delegate = self;
    _cashConvertCheckInfoView.bankLabel.text = @"淮北农商银行";
    _cashConvertCheckInfoView.nameLabel.text = @"张三";
    _cashConvertCheckInfoView.phoneLabel.text = @"15000000000";
    _cashConvertCheckInfoView.cashLabel.text = @"50元";
    _cashConvertCheckInfoView.scoreLabel.text = @"5000";
    [kWindow addSubview:_cashConvertCheckInfoView];
    
    
}
- (void)cashConvertCheckInfoView:(CashConvertCheckInfoView *)view didClickedCloseButton:(UIButton *)button{
    [view removeFromSuperview];
}
- (void)cashConvertCheckInfoView:(CashConvertCheckInfoView *)view didClickedModifyButton:(UIButton *)button{
    [view removeFromSuperview];
}
- (void)cashConvertCheckInfoView:(CashConvertCheckInfoView *)view didClickedSubmitButton:(UIButton *)button {
    [view removeFromSuperview];
    _cashConvertSuccessView = [[CashConvertSuccessView alloc] init];
    [_cashConvertSuccessView.closeButton addTarget:self action:@selector(removeSuccessView:) forControlEvents:UIControlEventTouchUpInside];
    [kWindow addSubview:_cashConvertSuccessView];
    
}
- (void)removeSuccessView:(UIButton *)sender {
    [_cashConvertSuccessView removeFromSuperview];
    _cashConvertSuccessView = nil;
}
@end
