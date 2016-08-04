//
//  ActivityTitleView.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ActivityTitleView.h"

@implementation ActivityTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *line = [UIView new];
        line.backgroundColor = LINE_COLOR;
        line.frame = CGRectMake(0, self.height-1, self.width, 1);
        [self addSubview:line];
        
        UILabel *titleLabel = [UILabel new];
//        label.backgroundColor = [UIColor orangeColor];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.text = @"活动标题";
        titleLabel.frame = CGRectMake(5, 0, 65, self.height);
        [self addSubview:titleLabel];
        
        UIImageView *pictureView = [UIImageView new];
        pictureView.userInteractionEnabled = YES;
        self.activityImageView = pictureView;
        CGFloat height = self.height-6;
        CGFloat width = 2.9/2*height;
        pictureView.frame = CGRectMake(self.width-width-5, 3, width, height);
        [self addSubview:pictureView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage)];
        [pictureView addGestureRecognizer:tap];
        
        UIImageView *imageView = [UIImageView new];
        self.addImageView = imageView;
        UIImage *image = [UIImage imageNamed:@"发布活动内容-添加标题小图标"];
        height = pictureView.height - 14;
        width = image.size.width / image.size.height * height;
        imageView.image = image;
        imageView.frame = CGRectMake(0, 7, width, height);
        [pictureView addSubview:imageView];
        
        UILabel *label = [UILabel new];
        self.addLabel = label;
        label.text = @"添加标题图片";
        label.textColor = [UIColor lightGrayColor];
        label.frame = CGRectMake(imageView.width, 0, pictureView.width-imageView.width, pictureView.height);
        label.font = [UIFont systemFontOfSize:5];
        [pictureView addSubview:label];
        
        UITextField *titleTextField = [UITextField new];
        self.titleTextField = titleTextField;
        titleTextField.frame = CGRectMake(titleLabel.x+titleLabel.width+3, 0, self.width-16-titleLabel.width-pictureView.width, self.height);
        [self addSubview:titleTextField];
        
        
    }
    return self;
}
- (void)selectImage {
    if (self.delegate && [self.delegate respondsToSelector:@selector(activityTitleViewSelectImage:)]) {
        [self.delegate activityTitleViewSelectImage:self];
    }
}
@end
