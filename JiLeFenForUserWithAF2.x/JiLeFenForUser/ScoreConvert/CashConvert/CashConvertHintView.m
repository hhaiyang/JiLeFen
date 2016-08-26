//
//  CashConvertHintView.m
//  JiLeFenForUser
//
//  Created by hhy on 16/8/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CashConvertHintView.h"

@implementation CashConvertHintView
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
    [_closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_closeButton];
    
    //显示温馨提示的标签
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:17];
    label.text = @"温馨提示";
    label.frame = CGRectMake(10, 20, contentView.width-20, 20);
    label.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:label];
    
    //显示提示内容的text view
    UITextView *textView = [UITextView new];
    textView.textColor = [UIColor grayColor];
    textView.font = [UIFont systemFontOfSize:14];
    textView.text = @"1、用户兑换的现金不提供发票；\n2、所兑换的积分点击“提交”后，积分即清除，概不退还积分；\n3、请仔细审核所填的资料，保证填写的银行卡真实有效；\n4、积了分的工作人员会在次日下午18:00前将现金转入您的银行卡内；\n5，在此期间，请保持电话通畅；\n6，点击“下一步”即视为同意以上所述；\n7、本次活动的最终解释权归积了分所有。";
    textView.userInteractionEnabled = NO;
    textView.frame = CGRectMake(10, label.y+label.height+15, contentView.width-20, 215);
    [contentView addSubview:textView];
    
    //返回和下一步
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, textView.y+textView.height+15, contentView.width, 25);
    [contentView addSubview:view];
    
    NSArray *titles = @[@"返回", @"下一步"];
    width = view.width/2;
    for (int i = 0; i < 2; i++) {
        UIView *buttonView = [UIView new];
        buttonView.frame = CGRectMake(i*width, 0, width, view.height);
        [view addSubview:buttonView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.cornerRadius = 3;
        button.frame = CGRectMake((buttonView.width-60)/2, 0, 70, buttonView.height);
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.backgroundColor = kRGBColor(228, 51, 69);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buttonView addSubview:button];
        if (i == 0) {
            _backButton = button;
            [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            _nextStepButton = button;
            [button addTarget:self action:@selector(nextStepAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    

}
- (void)closeAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cashConvertHintView:didClickedCloseButton:)]) {
        [self.delegate cashConvertHintView:self didClickedCloseButton:sender];
    }
    
}
- (void)backAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cashConvertHintView:didClickedBackButton:)]) {
        [self.delegate cashConvertHintView:self didClickedBackButton:sender];
    }

}
- (void)nextStepAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cashConvertHintView:didClickedNextStepButton:)]) {
        [self.delegate cashConvertHintView:self didClickedNextStepButton:sender];
    }

}

@end
