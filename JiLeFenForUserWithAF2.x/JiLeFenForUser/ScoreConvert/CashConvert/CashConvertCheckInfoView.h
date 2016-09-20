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

//现金积分核对信息界面
@interface CashConvertCheckInfoView : PopView
//右上角关闭按钮
@property (nonatomic, strong) UIButton *closeButton;
//修改按钮
@property (nonatomic, strong) UIButton *modifyButton;
//提交现金兑换请求按钮
@property (nonatomic, strong) UIButton *submitButton;
//显示银行名称的标签
@property (nonatomic, strong) UILabel *bankLabel;
//显示银行卡号的标签
@property (nonatomic, strong) UILabel *banknoLabel;
//显示持卡人姓名的标签
@property (nonatomic, strong) UILabel *nameLabel;
//显示持卡人手机号的标签
@property (nonatomic, strong) UILabel *phoneLabel;
//显示要兑换的现金的标签
@property (nonatomic, strong) UILabel *cashLabel;
//显示要消耗的积分的标签
@property (nonatomic, strong) UILabel *scoreLabel;

@property (nonatomic, weak) id<CashConvertCheckInfoViewDelegate> delegate;
@end
