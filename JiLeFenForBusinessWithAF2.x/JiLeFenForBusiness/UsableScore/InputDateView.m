//
//  InputDateView.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "InputDateView.h"

#define InputDateTextFieldBorderColor kRGBColor(232, 232, 232)
#define InputDateTextFieldTextColor kRGBColor(227, 55, 72)

#define InputDateLabelWidth 15
#define InputDateTextFieldHeight 20

@implementation InputDateView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [UILabel new];
        self.label = label;
        label.frame = CGRectMake(self.width-InputDateLabelWidth, 0, InputDateLabelWidth, self.height);
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        UITextField *textField = [UITextField new];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.frame = CGRectMake(0, (self.height-InputDateTextFieldHeight)/2, self.width-InputDateLabelWidth, InputDateTextFieldHeight);
        self.textField = textField;
        textField.layer.borderWidth = 1;
        textField.layer.borderColor = [InputDateTextFieldBorderColor CGColor];
        textField.layer.cornerRadius = 1;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.font = [UIFont systemFontOfSize:13];
        textField.textColor = InputDateTextFieldTextColor;
        [self addSubview:textField];
        
    }
    return self;
}
@end
