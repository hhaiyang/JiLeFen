//
//  PartView.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/7/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"

@interface PartView : UIView
//活动图片
@property (nonatomic, strong) UIImageView *activityImageView;
//活动所属商家名
@property (nonatomic, strong) UILabel *businessNameLabel;
//活动标题
@property (nonatomic, strong) UILabel *activityTitleLabel;
//积分图片
@property (nonatomic, strong) UIImageView *integralImageView;
@property (nonatomic, strong) Activity *activity;
@end
