//
//  ModifyPasswordCell.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ModifyPasswordCell.h"

@implementation ModifyPasswordCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [UIView new];
        line.backgroundColor = LINE_COLOR;
        line.frame = CGRectMake(0, self.height-1, self.width, 1);
        [self addSubview:line];
        
        UITextField *inputTextField = [UITextField new];
        inputTextField.secureTextEntry = YES;
        self.inputTextField = inputTextField;
        inputTextField.frame = CGRectMake(30, 0, self.width-60, self.height);
        [self addSubview:inputTextField];
        
    }
    return self;
}
@end
