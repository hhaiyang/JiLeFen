//
//  AppointmentInfoView.m
//  JiLeFenForUser
//
//  Created by hhy on 16/8/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AppointmentInfoView.h"

@implementation AppointmentInfoView

- (void)setContentView {
    //内容视图
    UIView *contentView = [UIView new];
    contentView.backgroundColor = ContentViewBackgroundColor;
    CGFloat width = self.width-ContentViewLeftMargin*2;
    CGFloat height = 40+132+40+22+20;
    contentView.frame = CGRectMake(ContentViewLeftMargin, (self.height-height)/2, width, height);
    [self addSubview:contentView];
    
    //右上角关闭按钮
    _closeButton = [ViewUtil closeButtonWithPosition:CGPointMake(contentView.width-CloseButtonWidth+7, CloseButtonTopMargin) andWidth:CloseButtonWidth];
    [_closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_closeButton];
    
    //填写用户信息
    NSArray *titles = @[@"姓 氏", @"手 机", @"地 址"];
    NSArray *placeholds = @[@"请输入您的贵姓", @"请输入手机号码", @"请输入您的详细地址"];
    UIView *infoView = nil;
    for (int i = 0; i < 3; i++) {
        infoView = [UIView new];
        infoView.frame = CGRectMake(0, 40+i*44, contentView.width, 44);
        [contentView addSubview:infoView];
        
        UILabel *label = [UILabel new];
        label.text = titles[i];
        label.font = [UIFont systemFontOfSize:15];
        label.frame = CGRectMake(10, 0, 45, infoView.height);
        [infoView addSubview:label];
        
        UITextField *textField = [UITextField new];
        textField.placeholder = placeholds[i];
        textField.frame = CGRectMake(label.x+label.width+5, 0, infoView.width-label.x*2-label.width-5, infoView.height);
        [infoView addSubview:textField];
        
        UIView *line = [UIView new];
        line.frame = CGRectMake(0, infoView.height-2, infoView.width, 2);
        line.backgroundColor = kRGBColor(232, 232, 232);
        [infoView addSubview:line];
        if (i == 0) {
            _nameTextField = textField;
            line.backgroundColor = kRGBColor(229, 147, 157);
            
        } else if (i == 1) {
            _phoneTextField = textField;
            textField.keyboardType = UIKeyboardTypeNumberPad;
        } else {
            _addressTextField = textField;
        }
        
    }
    
    NSArray *buttonTitles = @[@"确定", @"返回"];
    for (int i = 0; i < 2; i++) {
        UIView *buttonView = [UIView new];
        buttonView.frame = CGRectMake(contentView.width/2*i, infoView.y+infoView.height+40, contentView.width/2, 22);
        [contentView addSubview:buttonView];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.backgroundColor = kRGBColor(228, 51, 69);
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        button.layer.cornerRadius = 2;
        button.frame = CGRectMake((buttonView.width-70)/2, 0, 70, buttonView.height);
        [buttonView addSubview:button];
        if (i == 0) {
            _sureButton = button;
            [button addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
            _backButton = button;
        }
        
    }

    
    
}
- (void)closeAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(appointmentInfoView:didClickedCloseButton:)]) {
        [self.delegate appointmentInfoView:self didClickedCloseButton:sender];
    }
}
- (void)sureAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(appointmentInfoView:didClickedSureButton:)]) {
        [self.delegate appointmentInfoView:self didClickedSureButton:sender];
    }
}
- (void)backAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(appointmentInfoView:didClickedBackButton:)]) {
        [self.delegate appointmentInfoView:self didClickedBackButton:sender];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

@end
