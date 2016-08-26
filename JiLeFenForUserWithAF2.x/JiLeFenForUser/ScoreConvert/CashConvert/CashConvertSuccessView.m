//
//  CashConvertSuccessView.m
//  JiLeFenForUser
//
//  Created by hhy on 16/8/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CashConvertSuccessView.h"

@implementation CashConvertSuccessView

- (void)setContentView {
    //内容视图
    UIView *contentView = [UIView new];
    contentView.backgroundColor = ContentViewBackgroundColor;
    CGFloat width = self.width-ContentViewLeftMargin*2;
    CGFloat height = 20+20+15+215+15+25+15;
    contentView.frame = CGRectMake(ContentViewLeftMargin, (self.height-height)/2, width, height);
    [self addSubview:contentView];
    
    //右上角关闭按钮
    _closeButton = [ViewUtil closeButtonWithPosition:CGPointMake(contentView.width-CloseButtonWidth+7, CloseButtonTopMargin) andWidth:CloseButtonWidth];
    [contentView addSubview:_closeButton];
    
    //成功图标
    height = 100;
    UIImageView *imageView = [ViewUtil successImageViewWithPosition:CGPointMake(0, 0) andHeight:height];
    CGPoint center = imageView.center;
    center.x = contentView.width/2;
    center.y = height/2+30;
    imageView.center = center;
    [contentView addSubview:imageView];
    
    //显示提交成功的标签
    UILabel *successLabel = [UILabel new];
    successLabel.text = @"您已提交成功！";
    successLabel.frame = CGRectMake(30, imageView.y+imageView.height+10, contentView.width-60, 21);
    [contentView addSubview:successLabel];
    
    //显示消息的标签
    UILabel *messageLabel = [UILabel new];
    messageLabel.numberOfLines = 0;
    messageLabel.text = @"请与次日下午18:00前查看银行卡余额，如未查询到，请致电客服电话：";
    CGRect rect = [messageLabel textRectForBounds:CGRectMake(0, 0, contentView.width-successLabel.x*2, CGFLOAT_MAX) limitedToNumberOfLines:0];
    messageLabel.frame = CGRectMake(successLabel.x, successLabel.y+successLabel.height, contentView.width-successLabel.x*2, rect.size.height);
    [contentView addSubview:messageLabel];
    
    //显示客服电话的label
    UILabel *phoneLabel = [UILabel new];
    phoneLabel.text = @"4008-916-128";
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    phoneLabel.textColor = kRGBColor(226, 48, 65);
    phoneLabel.frame = CGRectMake(10, messageLabel.y+messageLabel.height+10, contentView.width-20, 21);
    [contentView addSubview:phoneLabel];
    
    CGRect frame = contentView.frame;
    frame.size.height = phoneLabel.y+phoneLabel.height+25;
    contentView.frame = frame;

    
    
}

@end
