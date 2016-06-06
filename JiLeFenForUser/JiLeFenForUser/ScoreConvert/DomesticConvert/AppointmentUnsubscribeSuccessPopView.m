//
//  AppointmentUnsubscribeSuccessPopView.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/5.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AppointmentUnsubscribeSuccessPopView.h"

@implementation AppointmentUnsubscribeSuccessPopView


+ (instancetype)popView {
    AppointmentUnsubscribeSuccessPopView *view = [[[UINib nibWithNibName:@"AppointmentUnsubscribeSuccessPopView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    view.backgroundColor = [UIColor popColor];
    view.frame = kScreenBounds;
    return view;
}
@end
