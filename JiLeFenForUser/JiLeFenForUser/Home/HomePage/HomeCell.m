//
//  CategoryCell.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
    if (cell == nil) {
        cell = [[[UINib nibWithNibName:@"HomeCell" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
