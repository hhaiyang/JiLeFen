//
//  AppointmentUnsubscribePopView.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/4.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentUnsubscribePopView : UIView
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *abandonButton;
@property (weak, nonatomic) IBOutlet UIButton *treasureButton;
+ (instancetype)popView;
@end
