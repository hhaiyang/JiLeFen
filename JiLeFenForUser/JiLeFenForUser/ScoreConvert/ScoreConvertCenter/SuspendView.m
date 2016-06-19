//
//  SuspendView.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "SuspendView.h"

@implementation SuspendView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kRGBAColor(73, 73, 73, 0.6);
        UILabel *introLabel = [UILabel new];
        introLabel.text = @"我的积分：";
        introLabel.textAlignment = NSTextAlignmentCenter;
        introLabel.font = [UIFont systemFontOfSize:17];
        introLabel.textColor = [UIColor whiteColor];
        introLabel.frame = CGRectMake((self.width-90)/2, 3, 90, self.height-6);
        [self addSubview:introLabel];
        
        _cashScoreLabel = [UILabel new];
        _cashScoreLabel.textColor = [UIColor whiteColor];
        _cashScoreLabel.text = @"369";
        _cashScoreLabel.font = [UIFont systemFontOfSize:17];
        _cashScoreLabel.frame = CGRectMake(introLabel.x+introLabel.width, introLabel.y, self.width-10-introLabel.x-introLabel.width, introLabel.height);
        [self addSubview:_cashScoreLabel];
        
        UIImageView *imageView = [UIImageView new];
        CGFloat imageViewHeight = introLabel.height;
        UIImage *image = [UIImage imageNamed:@"可用积分小图标"];
        imageView.image = image;
        CGFloat imageViewWidth = image.size.width/image.size.height*imageViewHeight;
        imageView.frame = CGRectMake(introLabel.x-imageViewWidth-3, introLabel.y, imageViewWidth, imageViewHeight);
        [self addSubview:imageView];
    }
    return self;
}
@end
