//
//  ActivityDateView.h
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityDateView : UIView
@property (nonatomic, strong) UITextField *beginYearTextField;
@property (nonatomic, strong) UITextField *beginMonthTextField;
@property (nonatomic, strong) UITextField *beginDayTextField;
@property (nonatomic, strong) UITextField *endYearTextField;
@property (nonatomic, strong) UITextField *endMonthTextField;
@property (nonatomic, strong) UITextField *endDayTextField;
- (instancetype)initWithFrame:(CGRect)frame;
@end
