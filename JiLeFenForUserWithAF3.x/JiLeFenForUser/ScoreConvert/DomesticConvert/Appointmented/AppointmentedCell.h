//
//  AppointmentedCell.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/6/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentedCell : UITableViewCell
@property (nonatomic, strong) UIView *appointmentingContentView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UILabel *introLabel;

@property (strong, nonatomic) UIImageView *appointmentingImageView;
@property (strong, nonatomic) UILabel *serviceDateLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UILabel *convertDateLabel;
@property (strong, nonatomic) UILabel *successLabel;
@property (nonatomic, strong) UIView *firstLine;
@property (nonatomic, strong) UIView *secondLine;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
