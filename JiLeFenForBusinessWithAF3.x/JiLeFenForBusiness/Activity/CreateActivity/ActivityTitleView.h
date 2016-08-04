//
//  ActivityTitleView.h
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ActivityTitleView;
@protocol ActivityTitleViewDelegate <NSObject>
@optional
- (void)activityTitleViewSelectImage:(ActivityTitleView *)titleView;

@end

@interface ActivityTitleView : UIView
@property (nonatomic, strong) UIImageView *activityImageView;
@property (nonatomic, strong) UIImageView *addImageView;
@property (nonatomic, strong) UILabel *addLabel;
@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, weak) id<ActivityTitleViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame;
@end
