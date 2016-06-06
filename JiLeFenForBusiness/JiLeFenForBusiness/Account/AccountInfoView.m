//
//  AccountInfoView.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AccountInfoView.h"

@implementation AccountInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = [UIImageView new];
        self.logoImageView = imageView;
        imageView.image = [UIImage imageNamed:@"标志"];
        imageView.frame = CGRectMake(15, 15, 55, 55);
        [self addSubview:imageView];
        
        UIView *contentView = [UIView new];
        contentView.frame = CGRectMake(imageView.x+imageView.width+15, 0, self.width-imageView.width-15*2, self.height);
        [self addSubview:contentView];
        
        NSArray *titles = @[@"名称：", @"电话：", @"地址："];
        for (int index = 0; index < 3; index++) {
            UIView *view = [UIView new];
            view.frame = CGRectMake(0, contentView.height/3*index, contentView.width, contentView.height/3);
            [contentView addSubview:view];
            
            if (index == 0 || index == 1) {
                UIView *line = [UIView new];
                line.backgroundColor = LINE_COLOR;
                line.frame = CGRectMake(0, view.height-1, view.width, 1);
                [view addSubview:line];
            }
            
            UILabel *label = [UILabel new];
            label.textAlignment = NSTextAlignmentRight;
            label.text = titles[index];
            label.frame = CGRectMake(5, 0, 60, view.height);
            [view addSubview:label];
            
            UITextField *textField = [UITextField new];
            textField.frame = CGRectMake(label.x+label.width, 0, view.width-10-label.width, view.height);
            [view addSubview:textField];
            if (index == 0) {
                self.nameTextField = textField;
                textField.text = @"国美电器";
            } else if (index == 1) {
                self.telTextField = textField;
                textField.text = @"0561-5223784";
            } else if (index == 2) {
                self.addressTextField = textField;
                textField.text = @"孟山市，夜市西门";
            }
            
            
        }
        
    }
    return self;
}

@end
