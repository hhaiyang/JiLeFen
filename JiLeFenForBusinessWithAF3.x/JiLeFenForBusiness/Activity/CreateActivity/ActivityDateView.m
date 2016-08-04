//
//  ActivityDateView.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ActivityDateView.h"

@implementation ActivityDateView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *line = [UIView new];
        line.frame = CGRectMake(0, self.height-1, self.width, 1);
        line.backgroundColor = LINE_COLOR;
        [self addSubview:line];
        
        UILabel *dateLabel = [UILabel new];
        dateLabel.text = @"活动时间";
        dateLabel.frame = CGRectMake(5, 0, 65, self.height);
        dateLabel.textColor = [UIColor grayColor];
        dateLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:dateLabel];
        
        UIView *dateContentView = [UIView new];
        dateContentView.frame = CGRectMake(dateLabel.x+dateLabel.width, 0, self.width-dateLabel.width-10, self.height);
        [self addSubview:dateContentView];
        
        UILabel *middleLabel = [UILabel new];
        middleLabel.font = [UIFont systemFontOfSize:13];
        middleLabel.text = @"至";
        middleLabel.textAlignment = NSTextAlignmentCenter;
        CGFloat height = dateContentView.height;
        CGFloat width = 15;
        middleLabel.frame = CGRectMake((dateContentView.width-width)/2, 0, width, height);
        [dateContentView addSubview:middleLabel];
        
        UIView *dateView = nil;
        width = (dateContentView.width-middleLabel.width)/2;
        height = dateContentView.height;
        for (int i = 0; i < 2; i++) {
            dateView = [UIView new];
            dateView.frame = CGRectMake(i*(middleLabel.width+width), 0, width, height);
            [dateContentView addSubview:dateView];
            
            UIView *timeView = nil;
            UILabel *timeLabel = nil;
            UITextField *timeTextField = nil;
            CGFloat timeViewWidth = width / 3;
            CGFloat timeViewHeight = height;
            NSArray *arr = @[@"年", @"月", @"日"];
            for (int j = 0; j < 3; j++) {
                timeView = [UIView new];
                timeView.frame = CGRectMake(j*timeViewWidth, 0, timeViewWidth, timeViewHeight);
                [dateView addSubview:timeView];
                
                timeLabel = [UILabel new];
                timeLabel.text = arr[j];
                timeLabel.textAlignment = NSTextAlignmentCenter;
                timeLabel.font = [UIFont systemFontOfSize:10];
                timeLabel.frame = CGRectMake(timeView.width-10, 0, 10, timeView.height);
                [timeView addSubview:timeLabel];
                
                timeTextField = [UITextField new];
                timeTextField.keyboardType = UIKeyboardTypeNumberPad;
                timeTextField.textColor = [UIColor redColor];
                timeTextField.font = [UIFont systemFontOfSize:12];
                timeTextField.textAlignment = NSTextAlignmentCenter;
                timeTextField.layer.borderWidth = 1;
                timeTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
                timeTextField.layer.cornerRadius = 1;
                timeTextField.frame = CGRectMake(0, (timeView.height-20)/2, timeView.width-timeLabel.width, 20);
                [timeView addSubview:timeTextField];
                
                if (0 == i) {
                    if (0 == j) {
                        self.beginYearTextField = timeTextField;
                    } else if (1 == j) {
                        self.beginMonthTextField = timeTextField;
                    } else {
                        self.beginDayTextField = timeTextField;
                    }
                    
                } else {
                    if (0 == j) {
                        self.endYearTextField = timeTextField;
                    } else if (1 == j) {
                        self.endMonthTextField = timeTextField;
                    } else {
                        self.endDayTextField = timeTextField;
                    }
                }
                
            }
        }
        
    }
    return self;
}

@end
