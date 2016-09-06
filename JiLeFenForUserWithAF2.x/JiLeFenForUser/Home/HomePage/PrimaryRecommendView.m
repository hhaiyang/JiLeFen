//
//  PrimaryRecommendView.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/6/23.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PrimaryRecommendView.h"
#import "UIImageView+WebCache.h"

@implementation PrimaryRecommendView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@"标志"];
        [self addSubview:_imageView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    
}
- (void)setActivity:(Activity *)activity {
    _activity = activity;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:activity.thumb]];
}
@end
