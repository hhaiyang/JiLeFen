//
//  AppointmentUnsubscribePopView.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/4.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AppointmentUnsubscribePopView.h"

@implementation AppointmentUnsubscribePopView

- (void)setContentView {
    UIView *contentView = [UIView new];
    contentView.backgroundColor = ContentViewBackgroundColor;
    CGFloat width = self.width-ContentViewLeftMargin*2;
    CGFloat height = 40+21+5+21+15+45+20;
    contentView.frame = CGRectMake(ContentViewLeftMargin, (self.height-height)/2, width, height);
    [self addSubview:contentView];
    
    _closeButton = [ViewUtil closeButtonWithPosition:CGPointMake(contentView.width-CloseButtonWidth+7, CloseButtonTopMargin) andWidth:CloseButtonWidth];
    [contentView addSubview:_closeButton];
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"真的不要这次的服务吗？";
    label.frame = CGRectMake(10, 40, contentView.width-20, 21);
    [contentView addSubview:label];
    
    UILabel *hintLabel = [UILabel new];
    hintLabel.text = @"（温馨提示：预约好的时间段24小时内不可退订）";
    hintLabel.textColor = [UIColor redColor];
    hintLabel.font = [UIFont systemFontOfSize:10];
    hintLabel.frame = CGRectMake(10, label.y+label.height+5, contentView.width-20, 21);
    [contentView addSubview:hintLabel];
    
    
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, hintLabel.y+hintLabel.height+15, contentView.width, 45);
    [contentView addSubview:view];
    
    NSArray *images = @[@"家政退订-忍痛放弃", @"家政退订-继续珍惜"];
    for (int index = 0; index < 2; index++) {
        UIView *actionView = [UIView new];
        actionView.frame = CGRectMake(view.width/2*index, 0, view.width/2, view.height);
        [view addSubview:actionView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat buttonHeight = actionView.height;
        UIImage *image = [UIImage imageNamed:images[index]];
        CGFloat buttonWidth = image.size.width/image.size.height*buttonHeight;
        button.frame = CGRectMake((actionView.width-buttonWidth)/2, 0, buttonWidth, buttonHeight);
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.tag = index;
        
        [actionView addSubview:button];
        if (index == 0) {
            _abandonButton = button;
        } else {
            _treasureButton = button;
        }
        
        
        
    }
    
    
    
    
}

@end
