//
//  UnsubscribeSuccessView.h
//  JiLeFenForUser
//
//  Created by hhy on 16/8/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PopView.h"

@class UnsubscribeSuccessView;
@protocol UnsubscribeSuccessViewDelegate <NSObject>
@optional
- (void)unsubscribeSuccessView:(UnsubscribeSuccessView *)view didClickedCornerCloseButton:(UIButton *)button;

- (void)unsubscribeSuccessView:(UnsubscribeSuccessView *)view didClickedBottomCloseButton:(UIButton *)button;

@end

//物品兑换退订成功弹出框
@interface UnsubscribeSuccessView : PopView
@property (nonatomic, strong) UIButton *cornerCloseButton;
@property (nonatomic, strong) UIButton *bottomCloseButton;
@property (nonatomic, weak) id<UnsubscribeSuccessViewDelegate> delegate;
@end
