//
//  AppointmentCell.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/6/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AppointmentCell.h"

@implementation AppointmentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _dateLabel = [UILabel new];
        _dateLabel.text = @"09:00--11:00（含路程）";
        _dateLabel.textColor = [UIColor grayColor];
        _dateLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_dateLabel];
        
        _typeLabel = [UILabel new];
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        _typeLabel.text = @"家政服务";
        _typeLabel.textColor = [UIColor grayColor];
        _typeLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:_typeLabel];
        
        _countLabel = [UILabel new];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.textColor = [UIColor grayColor];
        _countLabel.text = @"1次";
        _countLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:_countLabel];
        
        _appointmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_appointmentButton setBackgroundImage:[UIImage imageNamed:@"家政兑换-预约可点击"] forState:UIControlStateNormal];
        [self addSubview:_appointmentButton];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat buttonHeight = 40;
    UIImage *buttonImage = [_appointmentButton backgroundImageForState:UIControlStateNormal];
    CGFloat buttonWidth = buttonImage.size.width/buttonImage.size.height*buttonHeight;
    _appointmentButton.frame = CGRectMake(self.width-buttonWidth-5, (self.height-buttonHeight)/2, buttonWidth, buttonHeight);
    _typeLabel.frame = CGRectMake(self.width-_appointmentButton.width-10-50, 10, 50, (self.height-20)/2);
    _countLabel.frame = CGRectMake(_typeLabel.x, _typeLabel.y+_typeLabel.height, _typeLabel.width, _typeLabel.height);
    _dateLabel.frame = CGRectMake(5, 10, self.width-20-_typeLabel.width-_appointmentButton.width, self.height-20);
    
}
@end
