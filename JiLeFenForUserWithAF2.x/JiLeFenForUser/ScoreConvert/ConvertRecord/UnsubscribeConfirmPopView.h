//
//  UnsubscribeConfirmPopView.h
//  JiLeFenForUser
//
//  Created by hhy on 16/8/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PopView.h"

@class UnsubscribeConfirmPopView;

@protocol UnsubscribeConfirmPopViewDelegate <NSObject>
@optional
- (void)unsubscribeConfirmPopView:(UnsubscribeConfirmPopView *)view didClickCloseButton:(UIButton *)button;
- (void)unsubscribeConfirmPopView:(UnsubscribeConfirmPopView *)view didClickGiveupButton:(UIButton *)button;
- (void)unsubscribeConfirmPopView:(UnsubscribeConfirmPopView *)view didClickCherishButton:(UIButton *)button;

@end

//退订确认弹出框
@interface UnsubscribeConfirmPopView : PopView
//关闭
@property (nonatomic, strong) UIButton *closeButton;
//忍痛放弃
@property (nonatomic, strong) UIButton *giveupButton;
//继续珍惜
@property (nonatomic, strong) UIButton *cherishButton;
@property (nonatomic, weak) id<UnsubscribeConfirmPopViewDelegate> delegate;
@end
