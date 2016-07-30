//
//  AppointmentUnsubscribeSuccessPopView.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/5.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AppointmentUnsubscribeSuccessPopView.h"

@implementation AppointmentUnsubscribeSuccessPopView

- (void)setContentView {
    UIView *contentView = [UIView new];
    contentView.backgroundColor = ContentViewBackgroundColor;
    CGFloat width = self.width-ContentViewLeftMargin*2;
    CGFloat height = 30+30+63+20+45;
    contentView.frame = CGRectMake(ContentViewLeftMargin, (self.height-height)/2, width, height);
    [self addSubview:contentView];
    
    _closeButton1 = [ViewUtil closeButtonWithPosition:CGPointMake(contentView.width-CloseButtonWidth+7, CloseButtonTopMargin) andWidth:CloseButtonWidth];
    [contentView addSubview:_closeButton1];
    
    NSArray *titles = @[@"退订成功！", @"系统退还剩余免费积分中，", @"请耐心等待！"];
    UILabel *label = nil;
    for (int index = 0; index < 3; index++) {
        label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = titles[index];
        label.frame = CGRectMake(10, 30+index*(21+10), contentView.width-20, 21);
        if (index == 0) {
            label.font = [UIFont systemFontOfSize:26];
        }
        [contentView addSubview:label];
        
        
    }
    
    _closeButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"关闭按钮"];
     height = 45;
     width = image.size.width/image.size.height*height;
    _closeButton2.frame = CGRectMake((contentView.width-width)/2, label.y+label.height+10, width, height);
    [_closeButton2 setBackgroundImage:image forState:UIControlStateNormal];
    [contentView addSubview:_closeButton2];
    
    
    
    
}

@end
