//
//  NotGetCell.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "NotGetCell.h"

@implementation NotGetCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NotGetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"notGetCell"];
    if (cell == nil) {
        cell = [[[UINib nibWithNibName:@"NotGetCell" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
@end
