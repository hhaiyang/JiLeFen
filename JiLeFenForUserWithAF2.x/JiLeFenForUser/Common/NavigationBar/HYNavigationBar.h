//
//  HYNavigationBar.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarButtonModel.h"
#import "HYBarButtonItem.h"
#import "HYButton.h"

@interface HYNavigationBar : UIView

@property(nonatomic, copy) NSString *title;
@property(nonatomic, strong) UIImageView *backgroundImageView;
@property(nonatomic, strong) UILabel * navLabel;
@property(nonatomic, strong) HYButton *leftBarButton;
@property(nonatomic, strong) HYButton *rightBarButton;
@property(nonatomic, strong) HYBarButtonItem *leftButtonItem;
@property(nonatomic, strong) HYBarButtonItem *rightButtonItem;
@property(nonatomic, copy) NSString *leftButtonState;

@end

