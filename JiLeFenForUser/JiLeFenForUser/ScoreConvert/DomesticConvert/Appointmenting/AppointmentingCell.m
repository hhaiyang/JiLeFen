//
//  AppointmentingCell.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AppointmentingCell.h"

@implementation AppointmentingCell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    AppointmentingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"appointmentingCell"];
    if (cell == nil) {
        cell = [[[UINib nibWithNibName:@"AppointmentingCell" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
        
        
    }
    return cell;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _appointmentingContentView = [UIView new];
        _appointmentingContentView.backgroundColor = [UIColor whiteColor];
        _appointmentingContentView.layer.cornerRadius = 2;
        [self addSubview:_appointmentingContentView];
        
        for (int index = 0; index < 2; index++) {
            UIView *line = [UIView new];
            line.backgroundColor = kRGBColor(249, 249, 249);
            if (index == 0) {
                _firstLine = line;
            } else {
                _secondLine = line;
            }
            [_appointmentingContentView addSubview:line];
        }
        
        for (int index = 0; index < 3; index++) {
            UIView *view = [UIView new];
            [_appointmentingContentView addSubview:view];
            if (index == 0) {
                _topView = view;
                _introLabel = [UILabel new];
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];
                NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"预约中" attributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:17]}];
                NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"(如需退订请在预约时间段24小时前取消预约，24小时内不可退订)" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10], NSForegroundColorAttributeName:[UIColor redColor]}];
                [str appendAttributedString:str1];
                [str appendAttributedString:str2];
                _introLabel.attributedText = str;
                
                
                [_topView addSubview:_introLabel];
            } else if (index == 1) {
                _middleView = view;
                _appointmentingImageView = [UIImageView new];
                _appointmentingImageView.image = [UIImage imageNamed:@"标志"];
                [view addSubview:_appointmentingImageView];
                
                for (int count = 0; count < 3; count++) {
                    UILabel *label = [UILabel new];
                    [view addSubview:label];
                    if (count == 0) {
                        _serviceDateLabel = label;
                        _serviceDateLabel.font = [UIFont systemFontOfSize:14];
                        _serviceDateLabel.textColor = [UIColor redColor];
                        _serviceDateLabel.text = @"10月5日 周一     18:00－20:00";
                        
                    } else if (count == 1) {
                        _contentLabel = label;
                        _contentLabel.font = [UIFont systemFontOfSize:11];
                        _contentLabel.textColor = [UIColor grayColor];
                        _contentLabel.text = @"请确保当天该时间段有人在家，方便打扫";
                    } else {
                        _convertDateLabel = label;
                        label.font = [UIFont systemFontOfSize:11];
                        label.textColor = [UIColor grayColor];
                        label.text = @"2015年09月30日兑换";
                    }
                }
            } else {
                _bottomView = view;
                _unsubscribeButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [_unsubscribeButton setBackgroundImage:[UIImage imageNamed:@"兑换记录-退订"] forState:UIControlStateNormal];
                [_bottomView addSubview:_unsubscribeButton];
                
            }
        }
        
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _appointmentingContentView.frame = CGRectMake(10, 5, self.width-20, self.height-10);
    _topView.frame = CGRectMake(0, 0, _appointmentingContentView.width, 34);
    _firstLine.frame = CGRectMake(0, _topView.height, _appointmentingContentView.width, 1);
    _middleView.frame = CGRectMake(0, _firstLine.y+_firstLine.height, _appointmentingContentView.width, _appointmentingContentView.height-2*_firstLine.height-_topView.height*2);
    _secondLine.frame = CGRectMake(0, _middleView.y+_middleView.height, _appointmentingContentView.width, 1);
    _bottomView.frame = CGRectMake(0, _secondLine.y+_secondLine.height, _appointmentingContentView.width, _topView.height);
    UIImage *image = [_unsubscribeButton backgroundImageForState:UIControlStateNormal];
    CGFloat buttonHeight = 30;
    CGFloat buttonWidth = image.size.width/image.size.height*buttonHeight;
    _unsubscribeButton.frame = CGRectMake(_bottomView.width-10-buttonWidth, (_bottomView.height-buttonHeight)/2, buttonWidth, buttonHeight);
    _appointmentingImageView.frame = CGRectMake(10, 10, _middleView.height-20, _middleView.height-20);
    _serviceDateLabel.frame = CGRectMake(_appointmentingImageView.x+_appointmentingImageView.width+10, 10, _middleView.width-30-_appointmentingImageView.width, (_middleView.height-20)/3);
    _contentLabel.frame = CGRectMake(_serviceDateLabel.x, _serviceDateLabel.y+_serviceDateLabel.height, _serviceDateLabel.width, _serviceDateLabel.height);
    _convertDateLabel.frame = CGRectMake(_serviceDateLabel.x, _contentLabel.y+_contentLabel.height, _serviceDateLabel.width, _serviceDateLabel.height);
    _introLabel.frame = CGRectMake(0, 0, _topView.width, _topView.height);
    
}
@end
