//
//  LookConvertCodePopView.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "LookConvertCodePopView.h"

@implementation LookConvertCodePopView
+ (instancetype)popView {
    LookConvertCodePopView *view = [[[UINib nibWithNibName:@"LookConvertCodePopView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    view.backgroundColor = [UIColor popColor];
    view.frame = kScreenBounds;
    return view;
}
- (void)setContentView {
    UIView *contentView = [UIView new];
    contentView.backgroundColor = ContentViewBackgroundColor;
    CGFloat width = self.width-ContentViewLeftMargin*2;
    CGFloat height = 187;
    contentView.frame = CGRectMake(ContentViewLeftMargin, (self.height-height)/2, width, height);
    [self addSubview:contentView];
    
    _closeButton = [ViewUtil closeButtonWithPosition:CGPointMake(contentView.width-CloseButtonWidth+7, CloseButtonTopMargin) andWidth:CloseButtonWidth];
    
    [contentView addSubview:_closeButton];
    
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.text = @"真的要取消关注吗？取消关注后将不再接收收该商家的活动消息？";
    label.frame = CGRectMake(20, 15, contentView.width-40, 109);
    [contentView addSubview:label];
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, label.y+label.height+5, contentView.width, 45);
    [contentView addSubview:view];
    
    NSArray *images = @[@"确定", @"取消"];
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
            _sureButton = button;
        } else {
            _cancelButton = button;
        }
        
        
        
    }
    
    
    
    
}
@end
