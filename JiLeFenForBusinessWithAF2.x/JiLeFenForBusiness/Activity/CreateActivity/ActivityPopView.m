//
//  ActivityPopView.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ActivityPopView.h"

@implementation ActivityPopView

- (void)setContentView {
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    CGFloat width = self.width-70;
    CGFloat height = 40+72+40+40+20;
    contentView.frame = CGRectMake(35, (self.height-height)/2, width, height);
    [self addSubview:contentView];
    width = 30;
    UIButton *closeButton = [ViewUtil closeButtonWithPosition:CGPointMake(contentView.width-width+7, -7) andWidth:width];
    self.closeButton = closeButton;
    [closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:closeButton];
    
    NSArray *textArr = @[@"请仔细核对活动内容，", @"一旦发布，不可更改！", @"（温馨提示：如需修改，请联系客服：4008-916-128）"];
    UILabel *label = nil;
    height = 21;
    for (int index = 0; index < textArr.count; index++) {
        label = [UILabel new];
        label.text = textArr[index];
        if (index == 2) {
            label.font = [UIFont systemFontOfSize:11];
            label.textColor = [UIColor redColor];
            label.numberOfLines = 2;
            height = 30;
        }
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(5, 40+index*(21+10), contentView.width-10, height);
                [contentView addSubview:label];
    }
    
    NSArray *images = @[@"发布活动内容-确定发布", @"发布活动内容-再看看"];
    UIView *view = nil;
    UIButton *button = nil;
    width = contentView.width/2;
    height = 40;
    for (int index = 0; index < images.count; index++) {
        view = [UIView new];
        view.frame = CGRectMake(index*width, label.y+label.height+20, width, height);
        [contentView addSubview:view];
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:images[index]];
        CGFloat buttonWidth = image.size.width/image.size.height*height;
        button.frame = CGRectMake((view.width-buttonWidth)/2, 0, buttonWidth, height);
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [view addSubview:button];
        if (index == 0) {
            [button addTarget:self action:@selector(createAction:) forControlEvents:UIControlEventTouchUpInside];
            self.createButton = button;
            
        } else {
            [button addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
            self.cancelButton = button;
        }
        
    }
}
- (void)closeAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(activityPopView:didClickedCloseButton:)]) {
        [self.delegate activityPopView:self didClickedCloseButton:sender];
    }
    
}
- (void)createAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(activityPopView:didClickedCreateButton:)]) {
        [self.delegate activityPopView:self didClickedCreateButton:sender];
    }
}
- (void)cancelAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(activityPopView:didClickedCancelButton:)]) {
        [self.delegate activityPopView:self didClickedCancelButton:sender];
    }
}
@end
