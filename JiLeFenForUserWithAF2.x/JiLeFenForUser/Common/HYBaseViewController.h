//
//  BaseViewController.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYNavigationBar.h"

@interface HYBaseViewController : UIViewController <UIGestureRecognizerDelegate>

/**
 *  是否隐藏navbar
 */
@property (nonatomic, assign) BOOL isNavbarHidden;

/**
 *  使用自定义的导航栏
 */
@property (nonatomic, strong) HYNavigationBar *navBarView;

/**
 *  返回controller的可布局视图区域
 *
 *  @return return value description
 */
- (CGRect)contentViewFrame;

/**
 *  初始化返回FireflyNavBarView的默认返回参数
 *
 *  @return return value description
 */
- (HYBarButtonItem *)backButtonItem;

/**
 *  导航栏点击默认返回按钮的回调事件
 */
- (void)doNavigationBack;

/**
 *  初始化导航栏
 */
- (void)initNavBarView;

@end
