//
//  SelectButton.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/6/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Commbox : UIView
@property (nonatomic, strong, readonly) UIImageView *indicatorImageView;
@property (nonatomic, strong, readonly) UILabel *nameLabel;
@property (nonatomic, strong, readonly) UIButton *button;
- (instancetype)initWithFrame:(CGRect)frame;
@end
