//
//  IntroductionView.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "IntroductionView.h"

@implementation IntroductionView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self createSubView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubView];
    }
    return self;
}
- (void)createSubView {
    self.titleLabel = [UILabel new];
    self.detailTextView = [UITextView new];
    self.detailTextView.editable = NO;
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailTextView];

}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(10, 0, self.bounds.size.width-10*2, 25);
    self.detailTextView.frame = CGRectMake(10, self.titleLabel.bounds.size.height, self.bounds.size.width-10*2, self.bounds.size.height-self.titleLabel.bounds.size.height);
}
@end
