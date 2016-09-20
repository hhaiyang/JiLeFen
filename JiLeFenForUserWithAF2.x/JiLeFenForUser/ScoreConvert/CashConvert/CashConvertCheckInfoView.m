//
//  CashConvertCheckInfoView.m
//  JiLeFenForUser
//
//  Created by hhy on 16/8/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CashConvertCheckInfoView.h"

@implementation CashConvertCheckInfoView

- (void)setContentView {
    //内容视图
    UIView *contentView = [UIView new];
    contentView.backgroundColor = ContentViewBackgroundColor;
    CGFloat width = self.width-ContentViewLeftMargin*2;
    CGFloat height = 20+20+15+180+10+21+15+25+15;
    contentView.frame = CGRectMake(ContentViewLeftMargin, (self.height-height)/2, width, height);
    [self addSubview:contentView];
    
    //右上角关闭按钮
    _closeButton = [ViewUtil closeButtonWithPosition:CGPointMake(contentView.width-CloseButtonWidth+7, CloseButtonTopMargin) andWidth:CloseButtonWidth];
    [_closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_closeButton];
    
    //核对信息提示标签
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:17];
    label.text = @"请您仔细核对以下信息：";
    label.frame = CGRectMake(10, 20, contentView.width-20, 20);
    label.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:label];
    
    //信息视图
    UIView *infoView = [UIView new];
    infoView.backgroundColor = kRGBColor(253, 235, 237);
    infoView.frame = CGRectMake(5, label.y+label.height+15, contentView.width-10, 180);
    [contentView addSubview:infoView];
    
    NSArray *titles = @[@"银行卡类型:", @"银 行 卡 号:", @"持有人姓名:", @"手 机 号 码:", @"兑 换 金 额:", @"消 耗 积 分:"];
    width = 85;
    height = infoView.height/6;
    for (int i = 0; i < 6; i++) {
        UILabel *label1 = [UILabel new];
        label1.text = titles[i];
        label1.textColor = [UIColor grayColor];
        label1.font = [UIFont systemFontOfSize:15];
        label1.frame = CGRectMake(15, i*height, width, height);
        [infoView addSubview:label1];
        
        UILabel *label2 = [UILabel new];
        label2.textColor = [UIColor redColor];
        label2.font = label1.font;
        label2.frame = CGRectMake(label1.x+label1.width, label1.y, infoView.width-label1.width-label1.x*2, label1.height);
        [infoView addSubview:label2];
        if (i == 0) {
            _bankLabel = label2;
        } else if (i == 1) {
            _banknoLabel = label2;
        } else if (i == 2) {
            _nameLabel = label2;
        } else if (i == 3) {
            _phoneLabel = label2;
        } else if (i == 4) {
            _cashLabel = label2;
        } else {
            _scoreLabel = label2;
        }
    }
    
    //确认无误后点击提交标签
    label = [UILabel new];
    label.text = @"确认无误后点击“提交”。";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:13];
    label.frame = CGRectMake(30, infoView.y+infoView.height+10, contentView.width-60, 21);
    [contentView addSubview:label];
    
    //修改和提交
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, label.y+label.height+15, contentView.width, 25);
    [contentView addSubview:view];
    
    titles = @[@"修改", @"提交"];
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
            _modifyButton = button;
            [button addTarget:self action:@selector(modifyAction:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            _submitButton = button;
            [button addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    
    
}
- (void)closeAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cashConvertCheckInfoView:didClickedCloseButton:)]) {
        [self.delegate cashConvertCheckInfoView:self didClickedCloseButton:sender];
    }
    
}
- (void)modifyAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cashConvertCheckInfoView:didClickedModifyButton:)]) {
        [self.delegate cashConvertCheckInfoView:self didClickedModifyButton:sender];
    }
    
}
- (void)submitAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cashConvertCheckInfoView:didClickedSubmitButton:)]) {
        [self.delegate cashConvertCheckInfoView:self didClickedSubmitButton:sender];
    }
    
}


@end
