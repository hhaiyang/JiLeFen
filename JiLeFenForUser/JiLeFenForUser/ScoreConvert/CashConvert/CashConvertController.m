//
//  CashConvertController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CashConvertController.h"
#import "SelectBankController.h"
#import "SuspendView.h"

@interface CashConvertController ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *cashScoreLabel;
@property (nonatomic, strong) UILabel *cashScoreStateLabel;
@property (nonatomic, strong) UITextField *cashTextField;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *bankTextField;

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
            NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"可用积分 " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
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
    NSArray *titles = @[@"金额", @"姓名", @"手机", @"卡号", @"银行"];
    NSArray *placeholds = @[@"请输入兑换金额（须为整数）", @"请输入银行卡持有人姓名", @"请输入手机号码", @"请输入银行卡号"];
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
            _backLabel = [UILabel new];
            _backLabel.text = @"点击选择银行卡开户行类型";
            _backLabel.textColor = [UIColor lightGrayColor];
            _backLabel.textAlignment = NSTextAlignmentRight;
            _backLabel.frame = CGRectMake(label.x+label.width+10, 0, inputView.width-20-label.width-label.x-10, inputView.height);
            [inputView addSubview:_backLabel];
            
            UITapGestureRecognizer *selectBankGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectBank)];
            [inputView addGestureRecognizer:selectBankGR];
            
        } else {
            UITextField *textField = [UITextField new];
            textField.placeholder = placeholds[index];
            textField.frame = CGRectMake(label.x+label.width, 0, inputView.width-30-label.width, inputView.height);
            [inputView addSubview:textField];
            if (index == 0) {
                _cashTextField = textField;
            } else if (index == 1) {
                _nameTextField = textField;
            } else if (index == 2) {
                _phoneTextField = textField;
            } else {
                _bankTextField = textField;
            }

        }
        
        
        
    }
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.layer.cornerRadius = 5;
    submitButton.frame = CGRectMake((_contentView.width-70)/2, inputView.y+inputView.height+7, 70, 30);
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    submitButton.backgroundColor = kRGBColor(228, 51, 69);
    [submitButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:submitButton];
    [self addKeyboardNotification];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    SuspendView *suspendView = [kWindow viewWithTag:1000];
    if (suspendView) {
        suspendView.hidden = NO;
    }

}
- (void)addKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWillShow:(NSNotification *)noti {
    
}
- (void)keyboardWillHide:(NSNotification *)noti {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)backAction {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)submit:(UIButton *)sender {
    [self.view endEditing:YES];
}
- (void)selectBank {
    [self.view endEditing:YES];
    SelectBankController *selectBank = [SelectBankController new];
    selectBank.cashConvertController = self;
    [self.navigationController pushViewController:selectBank animated:YES];
}
@end
