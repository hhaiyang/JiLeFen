//
//  ActivityPopView.h
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewUtil.h"
#import "PopView.h"
@class ActivityPopView;
@protocol  ActivityPopViewDelegate<NSObject>
@optional
- (void)activityPopView:(ActivityPopView *)popView didClickedCloseButton:(UIButton *)button;
- (void)activityPopView:(ActivityPopView *)popView didClickedCreateButton:(UIButton *)button;
- (void)activityPopView:(ActivityPopView *)popView didClickedCancelButton:(UIButton *)button;

@end
@interface ActivityPopView : PopView
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *createButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, weak) id<ActivityPopViewDelegate> delegate;
@end
