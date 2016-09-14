//
//  ButtomTabBar.h
//  优购淮北
//
//  Created by 李峰峰 on 15/8/18.
//  Copyright (c) 2015年 李峰峰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ButtomTabBar;

@protocol ButtomTabBarDelegate <NSObject>
@optional
-(void)tabBar:(ButtomTabBar *)tabBar didSelectButtomFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface ButtomTabBar : UIView

@property(nonatomic,weak) id<ButtomTabBarDelegate> delegate;

@end
