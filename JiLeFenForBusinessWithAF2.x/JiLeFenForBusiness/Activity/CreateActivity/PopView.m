//
//  PopView.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/23.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PopView.h"

#define POP_VIEW_BACKGROUND_COLOR kRGBAColor(179,179,179,0.5)

@implementation PopView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
        [self setContentView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self setContentView];
    }
    return self;
}
- (void)setup {
    self.backgroundColor = POP_VIEW_BACKGROUND_COLOR;
    self.frame = kScreenBounds;
}
- (void)setContentView {
    
}
@end
