//
//  SelectButton.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/6/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectView : UIView
@property (nonatomic, strong) UIImageView *indicatorImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *button;
- (instancetype)initWithFrame:(CGRect)frame;
@end
