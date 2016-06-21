//
//  AppointmentedCell.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/6/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentedCell : UITableViewCell
@property (nonatomic, strong) UIView *appointmentedContentView;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
