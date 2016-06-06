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
@end
