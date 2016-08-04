//
//  AccountInfoView.h
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountInfoView : UIView
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *telTextField;
@property (nonatomic, strong) UITextField *addressTextField;
- (instancetype)initWithFrame:(CGRect)frame;
@end
