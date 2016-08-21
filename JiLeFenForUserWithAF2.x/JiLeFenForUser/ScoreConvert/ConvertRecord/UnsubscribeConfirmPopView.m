//
//  UnsubscribeConfirmPopView.m
//  JiLeFenForUser
//
//  Created by hhy on 16/8/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "UnsubscribeConfirmPopView.h"

@implementation UnsubscribeConfirmPopView

- (void)setContentView {
    //内容视图
    UIView *contentView = [UIView new];
    contentView.backgroundColor = ContentViewBackgroundColor;
    CGFloat width = self.width-ContentViewLeftMargin*2;
    CGFloat height = 50+21+40+50+35;
    contentView.frame = CGRectMake(ContentViewLeftMargin, (self.height-height)/2, width, height);
    [self addSubview:contentView];
    
    //右上角关闭按钮
    _closeButton = [ViewUtil closeButtonWithPosition:CGPointMake(contentView.width-CloseButtonWidth+7, CloseButtonTopMargin) andWidth:CloseButtonWidth];
    [_closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_closeButton];
    
    //提示“真的不要伦家了么”标签
    UILabel *label = [UILabel new];
    label.text = @"真的不要伦家了么？";
    label.font = [UIFont systemFontOfSize:21];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(10, 50, contentView.width-20, 21);
    [contentView addSubview:label];
    
    //忍痛放弃和继续珍惜按钮
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, label.y+label.height+40, contentView.width, 50);
    [contentView addSubview:view];
    NSArray *images = @[@"家政退订-忍痛放弃", @"家政退订-继续珍惜"];
    width = view.width/2;
    height = view.height;
    for (int i = 0, j = (int)images.count; i < j; i++) {
        UIView *subview = [UIView new];
        subview.frame = CGRectMake(i*width, 0, width, height);
        [view addSubview:subview];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:images[i]];
        CGFloat buttonHeight = height;
        CGFloat buttonWidth = image.size.width/image.size.height*buttonHeight;
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.frame = CGRectMake((subview.width-buttonWidth)/2, 0, buttonWidth, buttonHeight);
        [subview addSubview:button];
        if (i == 0) {
            [button addTarget:self action:@selector(giveupAction:) forControlEvents:UIControlEventTouchUpInside];
            _giveupButton = button;
        } else {
            [button addTarget:self action:@selector(cherishAction:) forControlEvents:UIControlEventTouchUpInside];
            _cherishButton = button;
            
        }
    }
    
    
}

- (void)closeAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(unsubscribeConfirmPopView:didClickCloseButton:)]) {
        [self.delegate unsubscribeConfirmPopView:self didClickCloseButton:sender];
    }
    
}
- (void)giveupAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(unsubscribeConfirmPopView:didClickGiveupButton:)]) {
        [self.delegate unsubscribeConfirmPopView:self didClickGiveupButton:sender];
    }
    
}
- (void)cherishAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(unsubscribeConfirmPopView:didClickCherishButton:)]) {
        [self.delegate unsubscribeConfirmPopView:self didClickCherishButton:sender];
    }
}


@end
