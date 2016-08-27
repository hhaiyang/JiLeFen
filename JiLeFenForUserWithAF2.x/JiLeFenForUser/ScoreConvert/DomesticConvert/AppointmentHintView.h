//
//  AppointmentHintView.h
//  JiLeFenForUser
//
//  Created by hhy on 16/8/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PopView.h"
@class AppointmentHintView;
@protocol AppointmentHintViewDelegate <NSObject>
@optional
- (void)appointmentHintView:(AppointmentHintView *)view didClickedCloseButton:(UIButton *)button;
- (void)appointmentHintView:(AppointmentHintView *)view didClickedSureButton:(UIButton *)button;
- (void)appointmentHintView:(AppointmentHintView *)view didClickedCancelButton:(UIButton *)button;


@end


@interface AppointmentHintView : PopView
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *serviceLabel;
@property (nonatomic, weak) id<AppointmentHintViewDelegate> delegate;
@end
