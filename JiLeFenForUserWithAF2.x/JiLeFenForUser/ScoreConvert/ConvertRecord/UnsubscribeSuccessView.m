//
//  UnsubscribeSuccessView.m
//  JiLeFenForUser
//
//  Created by hhy on 16/8/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "UnsubscribeSuccessView.h"

@implementation UnsubscribeSuccessView

- (void)setContentView {
    //内容视图
    UIView *contentView = [UIView new];
    contentView.backgroundColor = ContentViewBackgroundColor;
    CGFloat width = self.width-ContentViewLeftMargin*2;
    CGFloat height = 45+21+10+21+15+27+25;
    contentView.frame = CGRectMake(ContentViewLeftMargin, (self.height-height)/2, width, height);
    [self addSubview:contentView];
    
    //右上角关闭按钮
    _cornerCloseButton = [ViewUtil closeButtonWithPosition:CGPointMake(contentView.width-CloseButtonWidth+7, CloseButtonTopMargin) andWidth:CloseButtonWidth];
    [_cornerCloseButton addTarget:self action:@selector(cornerCloseAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_cornerCloseButton];
    
    //退订成功标签
    UILabel *successLabel = [UILabel new];
    successLabel.text = @"退订成功！";
    successLabel.font = [UIFont systemFontOfSize:20];
    successLabel.textAlignment = NSTextAlignmentCenter;
    successLabel.frame = CGRectMake(10, 45, contentView.width-20, 21);
    [contentView addSubview:successLabel];
    
    //提示标签
    UILabel *messageLabel = [UILabel new];
    messageLabel.text = @"系统退还积分中，请稍等！";
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont systemFontOfSize:17];
    messageLabel.frame = CGRectMake(10, successLabel.y+successLabel.height+10, contentView.width-20, 21);
    [contentView addSubview:messageLabel];
    
    //关闭按钮
    _bottomCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _bottomCloseButton.backgroundColor = kRGBColor(228, 51, 69);
    [_bottomCloseButton setTitle:@"关 闭" forState:UIControlStateNormal];
    _bottomCloseButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _bottomCloseButton.layer.cornerRadius = 5;
    _bottomCloseButton.frame = CGRectMake((contentView.width-70)/2, messageLabel.y+messageLabel.height+15, 70, 27);
    [_bottomCloseButton addTarget:self action:@selector(bottomCloseAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_bottomCloseButton];
    
}



- (void)cornerCloseAction:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(unsubscribeSuccessView:didClickedCornerCloseButton:)]) {
        [self.delegate unsubscribeSuccessView:self didClickedCornerCloseButton:button];
    }
}
- (void)bottomCloseAction:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(unsubscribeSuccessView:didClickedBottomCloseButton:)]) {
        [self.delegate unsubscribeSuccessView:self didClickedBottomCloseButton:button];
    }
}
@end
