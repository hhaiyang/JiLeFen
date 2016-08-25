//
//  QueryScoreChangeView.h
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectDateView : UIView
@property (nonatomic, strong) UITextField *beginYearTextField;
@property (nonatomic, strong) UITextField *beginMonthTextField;
@property (nonatomic, strong) UITextField *endYearTextField;
@property (nonatomic, strong) UITextField *endMonthTextField;
- (instancetype)initWithFrame:(CGRect)frame;
@end
