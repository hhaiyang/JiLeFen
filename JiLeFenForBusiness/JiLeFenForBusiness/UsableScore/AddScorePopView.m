//
//  AddScorePopView.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AddScorePopView.h"

#define UsableLabelColor kRGBColor(232, 232, 232)

#define SuccessImageViewHeight 60
#define SuccessLabelHeight 21
#define UsableLabelHeight 30
#define BackButtonHeight 30

@implementation AddScorePopView

- (void)setContentView {
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    CGFloat width = self.width-2*ContentViewLeftMargin;
    CGFloat height = 20+SuccessImageViewHeight+20+SuccessLabelHeight+10+UsableLabelHeight+25+BackButtonHeight+20;
    contentView.frame = CGRectMake(35, (self.height-height)/2, width, height);
    [self addSubview:contentView];
    
    UIButton *closeButton = [ViewUtil closeButtonWithPosition:CGPointMake(contentView.width-CloseButtonWidth-CloseButtonTopMargin, CloseButtonTopMargin) andWidth:CloseButtonWidth];
    [closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    self.closeButton = closeButton;
    [contentView addSubview:closeButton];
    
    
    UIImageView *imageView = [ViewUtil successImageViewWithPosition:CGPointMake(0, 20) andHeight:SuccessImageViewHeight];
    CGPoint center = imageView.center;
    center.x = contentView.width/2;
    imageView.center = center;
    [contentView addSubview:imageView];
    
    UILabel *sucessLabel = [UILabel new];
    self.successLabel = sucessLabel;
    sucessLabel.frame = CGRectMake(10, imageView.y+imageView.height+20, contentView.width-20, SuccessLabelHeight);
    sucessLabel.textAlignment = NSTextAlignmentCenter;
    sucessLabel.font = [UIFont systemFontOfSize:15];
    [contentView addSubview:sucessLabel];
    
    UILabel *usableLabel = [UILabel new];
    self.usableScoreLabel = usableLabel;
    usableLabel.frame = CGRectMake(40, sucessLabel.y+sucessLabel.height+15, contentView.width-80, UsableLabelHeight);
    usableLabel.textAlignment = NSTextAlignmentCenter;
    usableLabel.backgroundColor = UsableLabelColor;
    [contentView addSubview:usableLabel];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.backButton = backButton;
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.backgroundColor = [UIColor redColor];
    backButton.layer.cornerRadius = 2;
    backButton.frame = CGRectMake((contentView.width-100)/2, usableLabel.y+usableLabel.height+25, 100, BackButtonHeight);
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
