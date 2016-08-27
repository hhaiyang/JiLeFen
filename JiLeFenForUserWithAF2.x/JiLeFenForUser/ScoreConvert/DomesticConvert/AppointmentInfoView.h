//
//  AppointmentInfoView.h
//  JiLeFenForUser
//
//  Created by hhy on 16/8/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PopView.h"

@class AppointmentInfoView;
@protocol AppointmentInfoViewDelegate <NSObject>

- (void)appointmentInfoView:(AppointmentInfoView *)view didClickedCloseButton:(UIButton *)button;
- (void)appointmentInfoView:(AppointmentInfoView *)view didClickedSureButton:(UIButton *)button;
- (void)appointmentInfoView:(AppointmentInfoView *)view didClickedBackButton:(UIButton *)button;

@end

@interface AppointmentInfoView : PopView
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *addressTextField;
@property (nonatomic, weak) id<AppointmentInfoViewDelegate> delegate;
@end
