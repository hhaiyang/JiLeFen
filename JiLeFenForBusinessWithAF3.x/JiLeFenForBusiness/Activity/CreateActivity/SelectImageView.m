//
//  SelectImageView.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "SelectImageView.h"

@implementation SelectImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *line = [UIView new];
        line.backgroundColor = LINE_COLOR;
        line.frame = CGRectMake(0, self.height-1, self.width, 1);
        [self addSubview:line];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.selectImageButton = button;
        UIImage *image = [UIImage imageNamed:@"发布活动内容-图库"];
        CGFloat height = self.height-20;
        CGFloat width = image.size.width/image.size.height*height;
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.frame = CGRectMake(10, 10, width, height);
        [self addSubview:button];
        
    }
    return self;
}

@end
