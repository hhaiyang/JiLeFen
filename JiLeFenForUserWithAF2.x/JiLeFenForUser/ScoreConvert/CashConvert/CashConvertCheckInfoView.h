//
//  CashConvertCheckInfoView.h
//  JiLeFenForUser
//
//  Created by hhy on 16/8/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PopView.h"

@class CashConvertCheckInfoView;

@protocol CashConvertCheckInfoViewDelegate <NSObject>
@optional
- (void)cashConvertCheckInfoView:(CashConvertCheckInfoView *)view didClickedCloseButton:(UIButton *)button;
- (void)cashConvertCheckInfoView:(CashConvertCheckInfoView *)view didClickedModifyButton:(UIButton *)button;
- (void)cashConvertCheckInfoView:(CashConvertCheckInfoView *)view didClickedSubmitButton:(UIButton *)button;

@end


@interface CashConvertCheckInfoView : PopView

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *modifyButton;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UILabel *bankLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *cashLabel;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, weak) id<CashConvertCheckInfoViewDelegate> delegate;
@end
