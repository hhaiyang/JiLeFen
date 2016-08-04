//
//  InputDateView.h
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputDateView : UIView
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *label;
- (instancetype)initWithFrame:(CGRect)frame;
@end
