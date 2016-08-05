//
//  AddScorePopView.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AddScorePopView.h"

#define UsableLabelColor kRGBColor(232, 232, 232)


@implementation AddScorePopView

- (void)setContentView {
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    CGFloat width = self.width-2*ContentViewLeftMargin;
    CGFloat height = 30+21*2+10*3+30;
    contentView.frame = CGRectMake(35, (self.height-height)/2, width, height);
    [self addSubview:contentView];
    
    UIButton *closeButton = [ViewUtil closeButtonWithPosition:CGPointMake(contentView.width-CloseButtonWidth-CloseButtonTopMargin, CloseButtonTopMargin) andWidth:CloseButtonWidth];
    [closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    self.closeButton = closeButton;
    [contentView addSubview:closeButton];
    
    UILabel *label = nil;
    for (int index = 0; index < 2; index++) {
        label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:20];
        label.frame = CGRectMake(5, 30+index*(21+10), contentView.width-10, 21);
        [contentView addSubview:label];
        if (index == 0) {
            label.text = @"索要积分请联系客服";
        } else {
            NSMutableAttributedString *str = [NSMutableAttributedString new];
            NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"客服：" attributes:nil];
            NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"4008-916-128" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
            [str appendAttributedString:str1];
            [str appendAttributedString:str2];
            label.attributedText = str;
        }
        
    }
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.backButton = backButton;
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.backgroundColor = [UIColor redColor];
    backButton.layer.cornerRadius = 2;
    backButton.frame = CGRectMake((contentView.width-100)/2, label.y+label.height+10, 100, 30);
    [contentView addSubview:backButton];
    
}
- (void)back:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(addScorePopView:didClickedBackButton:)]) {
        [self.delegate addScorePopView:self didClickedBackButton:sender];
    }
}
- (void)close:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(addScorePopView:didClickedCloseButton:)]) {
        [self.delegate addScorePopView:self didClickedCloseButton:sender];
    }
}
@end
