//
//  AppointmentingCell.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  预约中cell
 */
@interface AppointmentingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *appointmentingImageView;
@property (weak, nonatomic) IBOutlet UILabel *appointmentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *convertTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *unsubscribeButton;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
