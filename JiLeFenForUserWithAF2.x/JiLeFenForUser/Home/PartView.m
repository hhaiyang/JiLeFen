//
//  PartView.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/7/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PartView.h"
#import "UIImageView+WebCache.h"

@implementation PartView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //活动图片
        _activityImageView = [UIImageView new];
        [self addSubview:_activityImageView];
        
        //活动所属商家名字
        _businessNameLabel = [UILabel new];
        _businessNameLabel.font = [UIFont systemFontOfSize:15];
        _businessNameLabel.numberOfLines = 0;
        [self addSubview:_businessNameLabel];
        
        //活动标题
        _activityTitleLabel = [UILabel new];
        _activityTitleLabel.numberOfLines = 0;
        _activityTitleLabel.textColor = [UIColor grayColor];
        _activityTitleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_activityTitleLabel];
        
        //活动积分图片
        _integralImageView = [UIImageView new];
        [self addSubview:_integralImageView];
        
        
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _activityImageView.frame = CGRectMake(self.width-self.height+10, 0, self.height-10, self.height-10);
    _businessNameLabel.frame = CGRectMake(0, 0, self.width-self.height, self.height/2);
    _activityTitleLabel.frame = CGRectMake(0, _businessNameLabel.height, _businessNameLabel.width, _businessNameLabel.height);
    UIImage *image = _integralImageView.image;
    CGFloat width = 50;
    CGFloat height = image.size.height/image.size.width*width;
    _integralImageView.frame = CGRectMake(0, 0, width, height);
    CGPoint center = _integralImageView.center;
    center.x = self.width/2+10;
    _integralImageView.center = center;
    
    
}
- (void)setActivity:(Activity *)activity {
    _activity = activity;
    [_activityImageView sd_setImageWithURL:[NSURL URLWithString:activity.thumb]];
    _businessNameLabel.text = activity.business.name;
    NSArray *integralImages = @[@"mark_int_2", @"mark_int_3", @"mark_int_4", @"mark_int_5", @"mark_int_6", @"mark_int_7", @"mark_int_8", @"mark_int_9", @"mark_int_10"];
    int number = [activity.integral intValue];
    _integralImageView.image = [UIImage imageNamed:integralImages[number-2]];
    _activityTitleLabel.text = activity.title;
}

@end
