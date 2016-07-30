//
//  AllCategoryCell.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    CategoryCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell"];
    if (cell == nil) {
        cell = [[[UINib nibWithNibName:@"CategoryCell" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    }
    return cell;
}

@end
