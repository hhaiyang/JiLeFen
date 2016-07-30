//
//  PrimaryRecommendView.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/6/23.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PrimaryRecommendView.h"

@implementation PrimaryRecommendView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@"标志"];
        [self addSubview:_imageView];
        
        _pointImageView = [UIImageView new];
        _pointImageView.image = [UIImage imageNamed:@""];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    
}
@end
