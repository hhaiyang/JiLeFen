//
//  SecondaryRecommendView.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/6/23.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"

@interface SecondaryRecommendView : UIView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) Activity *activity;
@end
