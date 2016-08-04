//
//  QueryScoreChangeView.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QueryScoreChangeView.h"
#import "InputDateView.h"

#define MiddleLabelWidth 15

@implementation QueryScoreChangeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *middleLabel = [UILabel new];
        middleLabel.text = @"至";
        middleLabel.textAlignment = NSTextAlignmentCenter;
        middleLabel.font = [UIFont systemFontOfSize:15];
        middleLabel.frame = CGRectMake((self.width-MiddleLabelWidth)/2, 0, MiddleLabelWidth, self.height);
        [self addSubview:middleLabel];
        
        UIView *view = nil;
        CGFloat height = self.height;
        CGFloat width = (self.width-80-MiddleLabelWidth)/2;
        for (int i = 0; i < 2; i++) {
            view = [UIView new];
            view.frame = CGRectMake(i*(40+MiddleLabelWidth+width)+20, 0, width, height);
            [self addSubview:view];
            
            InputDateView *dateView = nil;
            CGFloat inputDateViewWidth = view.width/5*3;
            CGFloat inputDateViewSpace = inputDateViewWidth;
            NSArray *titles = @[@"年", @"月"];
            for (int j = 0; j < 2; j++) {
                if (j == 1) {
                    inputDateViewWidth = view.width/5*2;
                }
                dateView = [[InputDateView alloc] initWithFrame:CGRectMake(inputDateViewSpace*j, 0, inputDateViewWidth, view.height)];
                dateView.label.text = titles[j];
                [view addSubview:dateView];
                if (i == 0 && j == 0) {
                    self.beginYearTextField = dateView.textField;
                } else if (i == 0 && j == 1) {
                    self.beginMonthTextField = dateView.textField;
                } else if (i == 1 && j == 0) {
                    self.endYearTextField = dateView.textField;
                } else {
                    self.endMonthTextField = dateView.textField;
                }
                
            }
            
            
        }
        
        
    }
    return self;
}

@end
