//
//  AppointmentSuccessView.h
//  JiLeFenForUser
//
//  Created by hhy on 16/8/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PopView.h"
@class AppointmentSuccessView;
@protocol AppointmentSuccessViewDelegate <NSObject>
@optional
- (void)appointmentSuccessView:(AppointmentSuccessView *)view didClickedCloseButton:(UIButton *)button;
- (void)appointmentSuccessView:(AppointmentSuccessView *)view didClickedSureButton:(UIButton *)button;
- (void)appointmentSuccessView:(AppointmentSuccessView *)view didClickedBackButton:(UIButton *)button;

@end

@interface AppointmentSuccessView : PopView
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, weak) id<AppointmentSuccessViewDelegate> delegate;
@end
