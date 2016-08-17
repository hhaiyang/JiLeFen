//
//  GoodsInfoView.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "GoodsInfoView.h"

#define kMargin 3
#define TextColor UIColorFromHexValue(0x969696)

@implementation GoodsInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [UILabel new];
        label.textColor = TextColor;
        self.textLabel = label;
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(kMargin, kMargin, self.width-2*kMargin, self.height-2*kMargin);
        [self addSubview:label];
    }
    return self;
}
@end
