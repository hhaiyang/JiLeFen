//
//  AppointmentUnsubscribePopView.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/4.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AppointmentUnsubscribePopView.h"

@implementation AppointmentUnsubscribePopView

+ (instancetype)popView {
    AppointmentUnsubscribePopView *view = [[[UINib nibWithNibName:@"AppointmentUnsubscribePopView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    view.backgroundColor = [UIColor popColor];
    view.frame = kScreenBounds;
    return view;
    
}
@end
