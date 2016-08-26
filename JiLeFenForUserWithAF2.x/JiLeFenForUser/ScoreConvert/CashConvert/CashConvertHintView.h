//
//  CashConvertHintView.h
//  JiLeFenForUser
//
//  Created by hhy on 16/8/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PopView.h"

@class CashConvertHintView;

@protocol CashConvertHintViewDelegate <NSObject>
@optional
- (void)cashConvertHintView:(CashConvertHintView *)view didClickedCloseButton:(UIButton *)button;
- (void)cashConvertHintView:(CashConvertHintView *)view didClickedBackButton:(UIButton *)button;
- (void)cashConvertHintView:(CashConvertHintView *)view didClickedNextStepButton:(UIButton *)button;

@end

@interface CashConvertHintView : PopView
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *nextStepButton;
@property (nonatomic, weak) id<CashConvertHintViewDelegate> delegate;
@end
