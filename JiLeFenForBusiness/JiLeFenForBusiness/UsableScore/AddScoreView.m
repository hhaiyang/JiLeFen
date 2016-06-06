//
//  AddScoreView.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AddScoreView.h"
#define AddScoreViewBackgroundColor kRGBColor(232, 232, 232)
#define TopMargin 5
#define AddScoreViewLineColor kRGBColor(214, 214, 214)

@implementation AddScoreView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = AddScoreViewBackgroundColor;
        self.layer.cornerRadius = 1;
        
        
    
        
        
        CGFloat width = 1;
        CGFloat height = self.height-2*TopMargin;
        UIView *line = [UIView new];
        line.backgroundColor = AddScoreViewLineColor;
        line.frame = CGRectMake((self.width-width)/2, TopMargin, width, height);
        [self addSubview:line];
        
        width = (self.width-line.width)/2;
        height = self.height;
        UIView *view = nil;
        for (int index = 0; index < 2; index++) {
            view = [UIView new];
            view.backgroundColor = [UIColor clearColor];
            view.frame = CGRectMake(index*(width+line.width), 0, width, height);
            [self addSubview:view];
            if (index == 0) {
                UILabel *label = [UILabel new];
                self.usableScoreLabel = label;
                label.frame = CGRectMake(TopMargin, TopMargin, view.width-2*TopMargin, view.height-2*TopMargin);
                label.textAlignment = NSTextAlignmentCenter;
                [view addSubview:label];
                
            } else {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                self.addScoreButton = button;
                UIImage *image = [UIImage imageNamed:@"索要积分小按钮"];
                CGFloat buttonHeight = view.height-2*TopMargin;
                CGFloat buttonWidth = image.size.width/image.size.height*buttonHeight;
                button.frame = CGRectMake((view.width-buttonWidth)/2, TopMargin, buttonWidth, buttonHeight);
                [button setBackgroundImage:image forState:UIControlStateNormal];
                [view addSubview:button];
                

                
            }
        }
        
    }
    return self;
}
@end
