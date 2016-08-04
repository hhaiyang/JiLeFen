//
//  ActivityContentView.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ActivityContentView.h"

@implementation ActivityContentView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *label = [UILabel new];
        label.text = @"正文";
        label.frame = CGRectMake(5, 0, self.width-10, 50);
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor grayColor];
        [self addSubview:label];
        
        UITextView *contentTextView = [UITextView new];
        contentTextView.font = [UIFont systemFontOfSize:15];
        contentTextView.backgroundColor = [UIColor whiteColor];
        contentTextView.frame = CGRectMake(5, label.height, self.width-10, self.height-1-label.height);
        self.contentTextView = contentTextView;
        [self addSubview:contentTextView];
        
        UIView *line = [UIView new];
        line.backgroundColor = LINE_COLOR;
        line.frame = CGRectMake(0, self.height-1, self.width, 1);
        [self addSubview:line];
        
    }
    return self;
}

@end
