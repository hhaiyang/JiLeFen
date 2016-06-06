//
//  ModifyScoreController.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ModifyScoreController.h"
#import "InputDateView.h"

#define ModifyScoreExpireViewTopHeight 30
#define ModifyScorePointViewTopHeight 30
#define ModifyScoreHintViewTopHeight 15
#define ModifyActionViewTopHeight 15
#define ModifyActionViewBottomHeight 15

#define ModifyScoreExpireViewHeight 21
#define ModifyScorePointViewHeight 21
#define ModifyScoreHintViewHeight 25
#define ModifyActionViewHeight 30

@interface ModifyScoreController ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *scorePointLabel;
@property (nonatomic, strong) UILabel *scoreExpireLabel;
@property (nonatomic, strong) UIView *modifyScoreView;
@property (nonatomic, strong) UIView *modifyScorePointView;
@property (nonatomic, strong) UITextField *beginYearTextField;
@property (nonatomic, strong) UITextField *beginMonthTextField;
@property (nonatomic, strong) UITextField *beginDayTextField;
@property (nonatomic, strong) UITextField *endYearTextField;
@property (nonatomic, strong) UITextField *endMonthTextField;
@property (nonatomic, strong) UITextField *endDayTextField;
@property (nonatomic, strong) UITextField *poinTextField;
@end

@implementation ModifyScoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DEFAULT_VIEW_CONTROLLER_BACKGROUND_COLOR;
    self.title = @"积分倍数修改";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(toForwardVC) imageName:@"二级页面返回小图标" height:30];
    self.navigationController.navigationBar.hidden = NO;
    [self setupSubviews];
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
    TEST_LOG(@"noti = %@", noti);
    if ([self.poinTextField isFirstResponder]) {
        CGRect modifyScorePointViewFrame = [self.modifyScoreView convertRect:self.modifyScorePointView.frame toView:self.view];
        CGRect keyboardEndFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        if (modifyScorePointViewFrame.origin.y+modifyScorePointViewFrame.size.height <= keyboardEndFrame.origin.y) {
            return;
        }
        CGFloat delta = modifyScorePointViewFrame.origin.y+modifyScorePointViewFrame.size.height - keyboardEndFrame.origin.y;
        CGRect contentViewFrame = self.contentView.frame;
        contentViewFrame.origin.y -= delta;
        NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        UIViewAnimationOptions option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:duration delay:0 options:option animations:^{
            weakSelf.contentView.frame = contentViewFrame;
            
        } completion:nil];
    }
    
}
- (void)keyboardWillHide:(NSNotification *)noti {
    CGRect contentViewFrame = self.contentView.frame;
    contentViewFrame.origin.y = 64;
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        weakSelf.contentView.frame = contentViewFrame;
        
    } completion:nil];

    
}
- (void)setupSubviews {
    
    UIView *contentView = [UIView new];
    self.contentView = contentView;
    contentView.backgroundColor = DEFAULT_VIEW_CONTROLLER_BACKGROUND_COLOR;
    contentView.frame = CGRectMake(0, 64, self.view.width, self.view.height-64);
    [self.view addSubview:contentView];
    
    UIView *scorePropertyView = [UIView new];
    scorePropertyView.frame = CGRectMake(0, 0, contentView.width, 88);
    scorePropertyView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:scorePropertyView];
    
    UIView *view = nil;
    CGFloat width = scorePropertyView.width;
    CGFloat height = scorePropertyView.height/2;
    NSArray *titles = @[@"目前积分倍数:", @"积 分 有 效 期:"];
    for (int index = 0; index < 2; index++) {
        view = [UIView new];
        view.frame = CGRectMake(0, index*height, width, height);
        [scorePropertyView addSubview:view];
        
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:13];
        label.frame = CGRectMake(3, 0, 90, view.height);
        label.text = titles[index];
        [view addSubview:label];
        if (index == 0) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(view.width-15-30, (view.height-20)/2, 30, 20);
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setTitle:@"修改" forState:UIControlStateNormal];
            [button setTitleColor:kRGBColor(255, 127, 167) forState:UIControlStateNormal];
            [button addTarget:self action:@selector(modifyScore) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
            
            UILabel *scorePointLabel = [UILabel new];
            self.scorePointLabel = scorePointLabel;
            scorePointLabel.font = [UIFont systemFontOfSize:15];
            scorePointLabel.frame = CGRectMake(label.x+label.width+10, 0, view.width-label.x-label.width-10-20-button.width-10, view.height);
            scorePointLabel.text = @"1倍积分（默认）";
            [view addSubview:scorePointLabel];
            
        } else {
            UILabel *scoreExpireLabel = [UILabel new];
            scoreExpireLabel.font = [UIFont systemFontOfSize:13];
            self.scoreExpireLabel = scoreExpireLabel;
            scoreExpireLabel.frame = CGRectMake(label.x+label.width, 0, view.width-6-label.width, view.height);
            scoreExpireLabel.text = @"2015年12月01日－2016年04月01日";
            [view addSubview:scoreExpireLabel];
        }
        
        
    }
    
    //修改积分倍数视图
    UIView *modifyScoreView = [UIView new];
    modifyScoreView.alpha = 0.5;
    modifyScoreView.userInteractionEnabled = NO;
    self.modifyScoreView = modifyScoreView;
    modifyScoreView.frame = CGRectMake(0, scorePropertyView.y+scorePropertyView.height+20, self.view.width, ModifyScoreExpireViewTopHeight+ModifyScoreExpireViewHeight+ModifyScorePointViewTopHeight+ModifyScorePointViewHeight+ModifyScoreHintViewTopHeight+ModifyScoreHintViewHeight+ModifyActionViewTopHeight+ModifyActionViewHeight+ModifyActionViewBottomHeight);
    modifyScoreView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:modifyScoreView];
    
    UIView *modifyScoreExpireView = [UIView new];
    modifyScoreExpireView.frame = CGRectMake(0, 30, modifyScoreView.width, ModifyScoreExpireViewHeight);
    [modifyScoreView addSubview:modifyScoreExpireView];
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:13];
    label.frame = CGRectMake(3, 0, 70, ModifyScoreExpireViewHeight);
    label.text = @"积分有效期:";
    [modifyScoreExpireView addSubview:label];
    
    UIView *modifyScoreExpireContentView = [UIView new];
    modifyScoreExpireContentView.frame = CGRectMake(label.x+label.width, 0, modifyScoreExpireView.width-6-label.width, ModifyScoreExpireViewHeight);
    [modifyScoreExpireView addSubview:modifyScoreExpireContentView];
    
    label = [UILabel new];
    label.text = @"至";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    width = 15;
    label.frame = CGRectMake((modifyScoreExpireContentView.width-width)/2, 0, width, ModifyScoreExpireViewHeight);
    [modifyScoreExpireContentView addSubview:label];
    
    UIView *modifyScoreExpireDateView = nil;
    titles = @[@"年", @"月", @"日"];
    width = (modifyScoreExpireContentView.width-label.width)/2;
    for (int i = 0; i < 2; i++) {
        modifyScoreExpireDateView = [UIView new];
        modifyScoreExpireDateView.frame = CGRectMake(i*(width+label.width), 0, width, ModifyScoreExpireViewHeight);
        [modifyScoreExpireContentView addSubview:modifyScoreExpireDateView];
        
        InputDateView *inputDateView = nil;
        CGFloat inputDateViewWidth = width/3;
        for (int j = 0; j < 3; j++) {
            inputDateView = [[InputDateView alloc] initWithFrame:CGRectMake(j*inputDateViewWidth, 0, inputDateViewWidth, ModifyScoreExpireViewHeight)];
            inputDateView.label.text = titles[j];
            [modifyScoreExpireDateView addSubview:inputDateView];
            if (i == 0 && j == 0) {
                self.beginYearTextField = inputDateView.textField;
            } else if (i == 0 && j == 1) {
                self.beginMonthTextField = inputDateView.textField;
            } else if (i == 0 && j == 2) {
                self.beginDayTextField = inputDateView.textField;
            } else if (i == 1 && j == 0) {
                self.endYearTextField = inputDateView.textField;
            } else if (i == 1 && j == 1) {
                self.endMonthTextField = inputDateView.textField;
            } else {
                self.endDayTextField = inputDateView.textField;
            }
        }
    }
    
    UIView *modifyScorePointView = [UIView new];
    self.modifyScorePointView = modifyScorePointView;
    modifyScorePointView.frame = CGRectMake(0, 30+ModifyScoreExpireViewHeight+30, modifyScoreView.width, ModifyScorePointViewHeight);
    [modifyScoreView addSubview:modifyScorePointView];
    
    label = [UILabel new];
    label.text = @"更   改   为:";
    label.font = [UIFont systemFontOfSize:13];
    label.frame = CGRectMake(3, 0, 70, ModifyScorePointViewHeight);
    [modifyScorePointView addSubview:label];
    
    label = [UILabel new];
    width = 120;
    label.frame = CGRectMake(modifyScorePointView.width-10-width, 0, width, ModifyScorePointViewHeight);
    label.text = @"(2-100)倍积分";
    label.textColor = kRGBColor(255, 117, 160);
    label.font = [UIFont systemFontOfSize:17];
    [modifyScorePointView addSubview:label];
    
    UITextField *textField = [UITextField new];
    self.poinTextField = textField;
    textField.textColor = kRGBColor(227, 55, 72);
    textField.frame = CGRectMake(75, 0, modifyScorePointView.width-75-130-3, ModifyScorePointViewHeight);
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [kRGBColor(232, 232, 232) CGColor];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.layer.cornerRadius = 2;
    textField.textAlignment = NSTextAlignmentCenter;
    [modifyScorePointView addSubview:textField];
    
    UIView *modifyScoreHintView = [UIView new];
    modifyScoreHintView.frame = CGRectMake(0, modifyScorePointView.y+ModifyScorePointViewHeight+ModifyScoreHintViewTopHeight, contentView.width, ModifyScoreHintViewHeight);
    [modifyScoreView addSubview:modifyScoreHintView];
    
    UILabel *hintLabel = [UILabel new];
    hintLabel.textColor = [UIColor grayColor];
    hintLabel.text = @"温馨提示：";
    hintLabel.textAlignment = NSTextAlignmentRight;
    hintLabel.font = [UIFont systemFontOfSize:10];
    hintLabel.frame = CGRectMake(3, 0, 55, ModifyScoreHintViewHeight/2);
    [modifyScoreHintView addSubview:hintLabel];
    
    UILabel *hintMessageLabel = [UILabel new];
    hintMessageLabel.numberOfLines = 0;
    hintMessageLabel.text = @"积分倍数在有效期内不可更改，过期后才可重新发布，若积分有效期内需要修改请联系客服：4008-916-128。";
    hintMessageLabel.frame = CGRectMake(hintLabel.x+hintLabel.width, 0, modifyScoreHintView.width-2*hintLabel.x-hintLabel.width, ModifyScoreHintViewHeight);
    hintMessageLabel.font = hintLabel.font;
    hintMessageLabel.textColor = hintLabel.textColor;
    [modifyScoreHintView addSubview:hintMessageLabel];
    
    UIView *modifyActionView = [UIView new];
    modifyActionView.frame = CGRectMake(0, modifyScoreHintView.y+modifyScoreHintView.height+ModifyActionViewTopHeight, modifyScoreView.width, ModifyActionViewHeight);
    [modifyScoreView addSubview:modifyActionView];
    
    width = modifyActionView.width/2;
    NSArray *images = @[@"积分倍数修改-保存", @"积分倍数修改-取消"];
    UIImage *image = nil;
    for (int index = 0; index < 2; index++) {
        UIView *view = [UIView new];
        view.frame = CGRectMake(index*width, 0, width, ModifyActionViewHeight);
        [modifyActionView addSubview:view];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        image = [UIImage imageNamed:images[index]];
        CGFloat buttonWidth = image.size.width/image.size.height*ModifyActionViewHeight;
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.frame = CGRectMake((view.width-buttonWidth)/2, 0, buttonWidth, ModifyActionViewHeight);
        [view addSubview:button];
        if (index == 0) {
            [button addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}
- (void)save {
    [self.view endEditing:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    if (self.beginYearTextField.text.length <= 0) {
        hud.label.text = @"请输入有效期的起始年份";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    if (self.beginMonthTextField.text.length <= 0) {
        hud.label.text = @"请输入有效期的起始月份";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    if (self.beginDayTextField.text.length <= 0) {
        hud.label.text = @"请输入有效期的起始日期";
        return;
    }
    if (self.endYearTextField.text.length <= 0) {
        hud.label.text = @"请输入有效期的结束年份";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    if (self.endMonthTextField.text.length <= 0) {
        hud.label.text = @"请输入有效期的结束月份";
        return;
    }
    if (self.endDayTextField.text.length <= 0) {
        hud.label.text = @"请输入有效期的结束日期";
        return;
    }
    if (self.poinTextField.text.length <= 0) {
        hud.label.text = @"请输入积分倍数";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    int point = [self.poinTextField.text intValue];
    if (point < 2 || point > 100) {
        hud.label.text = @"积分倍数范围为：2-100";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"保存中，请稍候";
    
    
}
- (void)cancel {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)modifyScore {
    self.modifyScoreView.userInteractionEnabled = YES;
    self.modifyScoreView.alpha = 1;
    
}

- (void)toForwardVC {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
