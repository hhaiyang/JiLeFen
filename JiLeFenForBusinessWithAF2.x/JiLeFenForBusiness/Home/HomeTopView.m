//
//  HomeTopView.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "HomeTopView.h"

@implementation HomeTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kRGBColor(28, 32, 44);
        
        UIImageView *logoImageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"首页logo"];
        logoImageView.image = image;
        CGFloat height = 25;
        CGFloat width = image.size.width/image.size.height*height;
        logoImageView.frame = CGRectMake(20, 10, width, height);
        [self addSubview:logoImageView];
        
        UIButton *accountButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.accountButton = accountButton;
        image = [UIImage imageNamed:@"首页-账户小图标"];
        height = 25;
        width = image.size.width/image.size.height*height;
        [accountButton setBackgroundImage:image forState:UIControlStateNormal];
        accountButton.frame = CGRectMake(self.width-width-20, 10, width, height);
        [self addSubview:accountButton];
        
        UIView *view = [UIView new];
        view.frame = CGRectMake(0, logoImageView.y+logoImageView.height+25, self.width, 65);
        [self addSubview:view];
        
        UIView *activityView = [UIView new];
        activityView.frame = CGRectMake(0, 0, view.width/2, view.height);
        [view addSubview:activityView];
        
        UIButton *activityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.activityButton = activityButton;
        image = [UIImage imageNamed:@"首页-发布活动小图标"];
        height = activityView.height-16;
        width = image.size.width/image.size.height*height;
        activityButton.frame = CGRectMake((activityView.width-width)/2, 0, width, height);
        [activityButton setBackgroundImage:image forState:UIControlStateNormal];
        [activityView addSubview:activityButton];
        
        UILabel *activityLabel = [UILabel new];
        activityLabel.text = @"发布活动";
        activityLabel.textAlignment = NSTextAlignmentCenter;
        activityLabel.textColor = [UIColor whiteColor];
        activityLabel.font = [UIFont systemFontOfSize:14];
        activityLabel.frame = CGRectMake(0, activityButton.height+3, activityView.width, activityView.height-activityButton.height-3);
        [activityView addSubview:activityLabel];
        
        UIView *goodsConvertView = [UIView new];
        goodsConvertView.frame = CGRectMake(view.width/2, 0, view.width/2, view.height);
        [view addSubview:goodsConvertView];
        
        UIButton *goodsConvertButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.goodsConvertButton = goodsConvertButton;
        image = [UIImage imageNamed:@"首页-物品兑换小图标"];
        height = goodsConvertView.height-16;
        width = image.size.width/image.size.height*height;
        goodsConvertButton.frame = CGRectMake((goodsConvertView.width-width)/2, 0, width, height);
        [goodsConvertButton setBackgroundImage:image forState:UIControlStateNormal];
        [goodsConvertView addSubview:goodsConvertButton];
        
        UILabel *goodsConvetLabel = [UILabel new];
        goodsConvetLabel.font = [UIFont systemFontOfSize:14];
        goodsConvetLabel.text = @"物品兑换";
        goodsConvetLabel.textColor = [UIColor whiteColor];
        goodsConvetLabel.textAlignment = NSTextAlignmentCenter;
        goodsConvetLabel.frame = CGRectMake(0, goodsConvertButton.y+goodsConvertButton.height+3, goodsConvertView.width, goodsConvertView.height-3-goodsConvertButton.height);
        [goodsConvertView addSubview:goodsConvetLabel];
        
    }
    return self;
}

@end
