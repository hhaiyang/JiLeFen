//
//  AddScorePopView.h
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PopView.h"

@class AddScorePopView;
@protocol AddScorePopViewDelegate <NSObject>
@optional
- (void)addScorePopView:(AddScorePopView *)view didClickedCloseButton:(UIButton *)button;
- (void)addScorePopView:(AddScorePopView *)view didClickedBackButton:(UIButton *)button;

@end

@interface AddScorePopView : PopView
@property (nonatomic, strong) UILabel *successLabel;
@property (nonatomic, strong) UILabel *usableScoreLabel;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, weak) id<AddScorePopViewDelegate> delegate;
@end
