//
//  AppointmentSuccessView.m
//  JiLeFenForUser
//
//  Created by hhy on 16/8/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AppointmentSuccessView.h"

@interface AppointmentSuccessView ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *userInfoView;
@property (nonatomic, strong) UILabel *hintLabel;
@property (nonatomic, strong) UILabel *hint1;
@property (nonatomic, strong) UILabel *hint2;
@property (nonatomic, strong) UIView *buttonView;
@end

@implementation AppointmentSuccessView

- (void)setContentView {
    //内容视图
    UIView *contentView = [UIView new];
    _contentView = contentView;
    contentView.backgroundColor = ContentViewBackgroundColor;
    CGFloat width = self.width-ContentViewLeftMargin*2;
    CGFloat height = 40+132+40+22+20;
    contentView.frame = CGRectMake(ContentViewLeftMargin, (self.height-height)/2, width, height);
    [self addSubview:contentView];
    
    //右上角关闭按钮
    _closeButton = [ViewUtil closeButtonWithPosition:CGPointMake(contentView.width-CloseButtonWidth+7, CloseButtonTopMargin) andWidth:CloseButtonWidth];
    [_closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_closeButton];
    
    UILabel *label = [UILabel new];
    label.text = @"您已预约成功";
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(10, 30, contentView.width-20, 21);
    [contentView addSubview:label];
    
    _timeLabel = [UILabel new];
    _timeLabel.frame = CGRectMake(0, label.y+label.height+10, contentView.width, 35);
    _timeLabel.text = @"周一10月5日  18:00-－20:00";
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.font = [UIFont systemFontOfSize:15];
    _timeLabel.textColor = kRGBColor(230, 63, 83);
    [contentView addSubview:_timeLabel];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = kRGBColor(241, 241, 241);
    line1.frame = CGRectMake(0, 1, _timeLabel.width, 1);
    [_timeLabel addSubview:line1];
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = line1.backgroundColor;
    line2.frame = CGRectMake(0, _timeLabel.height-1, _timeLabel.width, 1);
    [_timeLabel addSubview:line2];
    
    //显示预约的用户信息视图
    UIView *userInfoView = [UIView new];
    _userInfoView = userInfoView;
    userInfoView.backgroundColor = kRGBColor(253, 235, 236);
    userInfoView.frame = CGRectMake(10, _timeLabel.y+_timeLabel.height+10, contentView.width-20, 0);
    [contentView addSubview:userInfoView];
    
    NSArray *titles = @[@"姓 氏", @"电 话", @"地 址"];
    for (int i = 0; i < 3; i++) {
        label = [UILabel new];
        label.text = titles[i];
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:13];
        label.frame = CGRectMake(5, i*21, 45, 21);
        [userInfoView addSubview:label];
        
        UILabel *infoLabel = [UILabel new];
        infoLabel.font = label.font;
        infoLabel.textColor = kRGBColor(230, 63, 83);
        infoLabel.frame = CGRectMake(label.x+label.width, i*21, userInfoView.width-label.width-10, 21);
        [userInfoView addSubview:infoLabel];
        if (i == 0) {
            _nameLabel = infoLabel;
            _nameLabel.text = @"黄";
        } else if (i == 1) {
            _phoneLabel = infoLabel;
            _phoneLabel.text = @"13856139785";
        } else {
            _addressLabel = infoLabel;
            _addressLabel.numberOfLines = 0;
            infoLabel.text = @"如需退如需退订，请与时间段开始前24小时取消预定（至少提前1天），24小时内不能退订如需退如需退订，请与时间段开始前24小时取消预定（至少提前1天），24小时内不能退订如需退如需退订，请与时间段开始前24小时取消预定（至少提前1天），24小时内不能退订";
        }
    }
    
    UILabel *hintLabel = [UILabel new];
    _hintLabel = hintLabel;
    hintLabel.text = @"温馨提示:";
    hintLabel.font = [UIFont systemFontOfSize:11];
    hintLabel.frame = CGRectMake(10, 0, 50, 21);
    hintLabel.textColor = [UIColor grayColor];
    [contentView addSubview:hintLabel];
    
    UILabel *hint1 = [UILabel new];
    _hint1 = hint1;
    hint1.text = @"1、请保持手机畅通，有人在家中！";
    hint1.textColor = hintLabel.textColor;
    hint1.font = hintLabel.font;
    hint1.frame = CGRectMake(hintLabel.x+hintLabel.width, 0, contentView.width-hintLabel.width-hintLabel.x*2, 21);
    [contentView addSubview:hint1];
    
    UILabel *hin2 = [UILabel new];
    _hint2 = hin2;
    hin2.text = @"2、如需退订，请与时间段开始前24小时取消预定（至少提前1天），24小时内不能退订！";
    hin2.frame = CGRectMake(hint1.x, 0, hint1.width, hint1.height);
    hin2.textColor = hint1.textColor;
    hin2.font = hint1.font;
    hin2.numberOfLines = 0;
    [contentView addSubview:hin2];
    
    
    UIView *buttonView = [UIView new];
    _buttonView = buttonView;
    _buttonView.frame = CGRectMake(0, 0, contentView.width, 22);
    [contentView addSubview:buttonView];
    
    NSArray *buttonTitles = @[@"确定", @"返回"];
    for (int i = 0; i < 2; i++) {
        UIView *view = [UIView new];
        view.frame = CGRectMake(contentView.width/2*i, 0, contentView.width/2, 22);
        [buttonView addSubview:view];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.backgroundColor = kRGBColor(228, 51, 69);
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        button.layer.cornerRadius = 2;
        button.frame = CGRectMake((view.width-70)/2, 0, 70, view.height);
        [view addSubview:button];
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(appointmentSuccessView:didClickedCloseButton:)]) {
        [self.delegate appointmentSuccessView:self didClickedCloseButton:sender];
    }
}
- (void)sureAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(appointmentSuccessView:didClickedSureButton:)]) {
        [self.delegate appointmentSuccessView:self didClickedSureButton:sender];
    }
}
- (void)backAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(appointmentSuccessView:didClickedBackButton:)]) {
        [self.delegate appointmentSuccessView:self didClickedBackButton:sender];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    CGRect addressFrame = _addressLabel.frame;
    NSLog(@"font = %@", _addressLabel.font);
    CGRect frame = [_addressLabel textRectForBounds:CGRectMake(0, 0, addressFrame.size.width, CGFLOAT_MAX) limitedToNumberOfLines:0];
    NSLog(@"frame = %@", NSStringFromCGRect(frame));
    if (frame.size.height > addressFrame.size.height) {
        addressFrame.size.height = frame.size.height+4;
    }
    _addressLabel.frame = addressFrame;
    
    CGRect userInfoViewFrame = _userInfoView.frame;
    userInfoViewFrame.size.height = addressFrame.origin.y+addressFrame.size.height;
    _userInfoView.frame = userInfoViewFrame;
    
    CGRect hintFrame = _hintLabel.frame;
    hintFrame.origin.y = _userInfoView.y+_userInfoView.height+5;
    _hintLabel.frame = hintFrame;
    
    CGRect hint1Frame = _hint1.frame;
    hint1Frame.origin.y = _hintLabel.y;
    _hint1.frame = hint1Frame;
    
    CGRect hint2Frame = _hint2.frame;
    frame = [_hint2 textRectForBounds:CGRectMake(0, 0, hint2Frame.size.width, CGFLOAT_MAX) limitedToNumberOfLines:0];
    if (frame.size.height > hint2Frame.size.height) {
        hint2Frame.size.height = frame.size.height;
    }
    hint2Frame.origin.y = _hint1.y+_hint1.height;
    _hint2.frame = hint2Frame;
    
    CGRect buttonViewFrame = _buttonView.frame;
    buttonViewFrame.origin.y = _hint2.y+_hint2.height+10;
    _buttonView.frame = buttonViewFrame;
    
    CGRect contentViewFrame = _contentView.frame;
    contentViewFrame.size.height = _buttonView.y+_buttonView.height+20;
    contentViewFrame.origin.y = (self.height-contentViewFrame.size.height)/2;
    _contentView.frame = contentViewFrame;
    
}

@end
