//
//  LookConvertCodePopView.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "LookConvertCodePopView.h"

@implementation LookConvertCodePopView
- (void)setContentView {
    //内容视图
    UIView *contentView = [UIView new];
    contentView.backgroundColor = ContentViewBackgroundColor;
    CGFloat width = self.width-ContentViewLeftMargin*2;
    CGFloat height = 187;
    contentView.frame = CGRectMake(ContentViewLeftMargin, (self.height-height)/2, width, height);
    [self addSubview:contentView];
    
    //右上角关闭按钮
    _cornerCloseButton = [ViewUtil closeButtonWithPosition:CGPointMake(contentView.width-CloseButtonWidth+7, CloseButtonTopMargin) andWidth:CloseButtonWidth];
    [contentView addSubview:_cornerCloseButton];
    
    //显示商家名的标签
    UILabel *label = [UILabel new];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"[卡旺卡奶茶]";
    label.frame = CGRectMake(30, 33, contentView.width-60, 20);
    [contentView addSubview:label];
    
    //显示兑换的物品的标签
    label = [UILabel new];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"花生巧克力1杯";
    label.textColor = kRGBColor(254, 148, 140);
    label.frame = CGRectMake(30, 58, contentView.width-60, 20);
    [contentView addSubview:label];
    
    //分割线
    UIView *separator = [UIView new];
    separator.frame = CGRectMake(20, 93, contentView.width-40, 1);
    separator.backgroundColor = kRGBColor(230, 230, 230);
    [contentView addSubview:separator];
    
    //显示“兑换码”这几个字的标签
    label = [UILabel new];
    label.text = @"兑换码：";
    label.font = [UIFont systemFontOfSize:11];
    label.textColor = [UIColor grayColor];
    label.frame = CGRectMake(30, 109, 45, 21);
    [contentView addSubview:label];
    
    //显示兑换码的标签
    label = [UILabel new];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"0233 3561 5521 22";
    label.frame = CGRectMake(78, 109, contentView.width-78-30, 21);
    [contentView addSubview:label];
    
    //底部关闭按钮
    _bottomCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"关闭按钮"];
    width = 65;
    height = image.size.height/image.size.width*width;
    [_bottomCloseButton setBackgroundImage:image forState:UIControlStateNormal];
    _bottomCloseButton.frame = CGRectMake((contentView.width-width)/2, 140, width, height);
    [contentView addSubview:_bottomCloseButton];
}
@end
