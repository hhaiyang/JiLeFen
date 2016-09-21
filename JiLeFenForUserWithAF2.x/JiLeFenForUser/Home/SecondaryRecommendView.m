//
//  SecondaryRecommendView.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/6/23.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "SecondaryRecommendView.h"
#import "UIImageView+WebCache.h"

@implementation SecondaryRecommendView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@"标志"];
        [self addSubview:_imageView];
        
        _firstLabel = [UILabel new];
        [self addSubview:_firstLabel];
        
        _secondLabel = [UILabel new];
        _secondLabel.numberOfLines = 0;
        _secondLabel.textColor = [UIColor grayColor];
        _secondLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:_secondLabel];
        
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = CGRectMake(self.width-self.height, 0, self.height, self.height);
    _firstLabel.frame = CGRectMake(0, 0, self.width-_imageView.width-10, self.height/2);
    _secondLabel.frame = CGRectMake(0, _firstLabel.height, _firstLabel.width, _firstLabel.height);
    
    
}
- (void)setActivity:(Activity *)activity {
    _activity = activity;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:activity.thumb]];
    NSMutableAttributedString *str = [NSMutableAttributedString new];
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:activity.business.name attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@", activity.integral] attributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:@"倍积分" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    [str appendAttributedString:str1];
    [str appendAttributedString:str2];
    [str appendAttributedString:str3];
    _firstLabel.attributedText = str;
    _secondLabel.text = activity.title;
}
@end
