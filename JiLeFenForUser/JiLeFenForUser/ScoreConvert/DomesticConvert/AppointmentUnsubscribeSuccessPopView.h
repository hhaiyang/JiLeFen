//
//  AppointmentUnsubscribeSuccessPopView.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/5.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentUnsubscribeSuccessPopView : UIView

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *closeButtons;
+ (instancetype)popView;
@end
