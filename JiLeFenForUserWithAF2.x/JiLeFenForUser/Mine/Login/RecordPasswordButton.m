//
//  RecordPasswordButton.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/6/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "RecordPasswordButton.h"

@implementation RecordPasswordButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [UIImageView new];
        self.recordPasswordImageView = imageView;
        UIImage *image = [UIImage imageNamed:@"记住密码按钮-待选"];
        imageView.image = image;
        CGFloat height = frame.size.height;
        CGFloat width = image.size.width/image.size.height*height;
        imageView.frame = CGRectMake(0, 0, width, height);
        [self addSubview:imageView];
        
        UILabel *label = [UILabel new];
        label.textColor = [UIColor whiteColor];
        label.text = @"记住密码";
        width = frame.size.width-imageView.size.width-1;
        label.frame = CGRectMake(imageView.size.width+1, 0, width, height);
        label.font = [UIFont systemFontOfSize:18];
        [self addSubview:label];
        
        
    }
    return self;
}
@end
