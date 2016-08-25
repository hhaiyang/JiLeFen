//
//  SelectButton.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/6/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Commbox.h"

@implementation Commbox

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _indicatorImageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"DownIndicator"];
        _indicatorImageView.image = image;
        _indicatorImageView.userInteractionEnabled = YES;
        [self addSubview:_indicatorImageView];
        
        _nameLabel = [UILabel new];
        _nameLabel.userInteractionEnabled = YES;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.text = @"全部商区";
        [self addSubview:_nameLabel];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button = button;
        button.frame = self.bounds;
        [self addSubview:_button];
        
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    //指示图片的frame
    UIImage *image = _indicatorImageView.image;
    CGFloat width = 20;
    CGFloat height = image.size.height/image.size.width*width;
    _indicatorImageView.frame = CGRectMake(self.width-width, (self.height-height)/2, width, height);
    
    //nameLabel的frame
    _nameLabel.frame = CGRectMake(0, 0, self.width-_indicatorImageView.width, self.height);


    
}
@end
