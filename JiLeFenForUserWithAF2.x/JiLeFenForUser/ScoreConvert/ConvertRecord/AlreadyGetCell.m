//
//  AlreadyGetCell.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AlreadyGetCell.h"

@implementation AlreadyGetCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    AlreadyGetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"alreadyGetCell"];
    if (cell == nil) {
        cell = [[[UINib nibWithNibName:@"AlreadyGetCell" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
