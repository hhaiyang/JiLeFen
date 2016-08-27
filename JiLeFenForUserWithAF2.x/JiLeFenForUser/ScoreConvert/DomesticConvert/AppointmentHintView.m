//
//  AppointmentHintView.m
//  JiLeFenForUser
//
//  Created by hhy on 16/8/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AppointmentHintView.h"

@implementation AppointmentHintView
- (void)setContentView {
    //内容视图
    UIView *contentView = [UIView new];
    contentView.backgroundColor = ContentViewBackgroundColor;
    CGFloat width = self.width-ContentViewLeftMargin*2;
    CGFloat height = 40+21+20+35+30+22+30;
    contentView.frame = CGRectMake(ContentViewLeftMargin, (self.height-height)/2, width, height);
    [self addSubview:contentView];
    
    //右上角关闭按钮
    _closeButton = [ViewUtil closeButtonWithPosition:CGPointMake(contentView.width-CloseButtonWidth+7, CloseButtonTopMargin) andWidth:CloseButtonWidth];
    [_closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_closeButton];
    
    //提示标签
    UILabel *label = [UILabel new];
    label.text = @"您确定预约（消减2000积分）";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = kRGBColor(230, 63, 83);
    label.frame = CGRectMake(10, 40, contentView.width-20, 21);
    [contentView addSubview:label];
    
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(15, label.y+label.height+20, contentView.width-30, 35);
    view.layer.cornerRadius = 5;
    view.layer.borderWidth = 1;
    view.layer.borderColor = [kRGBColor(231, 188, 193) CGColor];
    [contentView addSubview:view];
    NSArray *titles = @[@"18:00--20:00", @"家政服务一次"];
    NSArray *buttonTitles = @[@"确 定", @"取 消"];
    width = (view.width-15)/2;
    for (int i = 0; i < 2; i++) {
        label = [UILabel new];
        label.textColor = [UIColor grayColor];
        label.frame = CGRectMake(5+i*(5+width), 0, width, view.height);
        label.text = titles[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        [view addSubview:label];
        
        UIView *buttonView = [UIView new];
        buttonView.frame = CGRectMake(contentView.width/2*i, view.y+view.height+30, contentView.width/2, 22);
        [contentView addSubview:buttonView];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.backgroundColor = kRGBColor(228, 51, 69);
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        button.layer.cornerRadius = 2;
        button.frame = CGRectMake((buttonView.width-70)/2, 0, 70, buttonView.height);
        [buttonView addSubview:button];
        if (i == 0) {
            _timeLabel = label;
            _sureButton = button;
            [button addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            _serviceLabel = label;
            [button addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
            _cancelButton = button;
        }
        
    }
    
    
    
}
- (void)closeAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(appointmentHintView:didClickedCloseButton:)]) {
        [self.delegate appointmentHintView:self didClickedCloseButton:sender];
    }
}
- (void)sureAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(appointmentHintView:didClickedSureButton:)]) {
        [self.delegate appointmentHintView:self didClickedSureButton:sender];
    }
}
- (void)cancelAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(appointmentHintView:didClickedCancelButton:)]) {
        [self.delegate appointmentHintView:self didClickedCancelButton:sender];
    }
}

@end
