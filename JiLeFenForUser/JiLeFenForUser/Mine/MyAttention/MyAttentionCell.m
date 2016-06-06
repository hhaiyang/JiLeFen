//
//  MyAttentionCell.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyAttentionCell.h"

@implementation MyAttentionCell
+ (instancetype)myAttentionCellWithTableView:(UITableView *)tableView {
    static NSString *reuseIdentifierOfMyAttentionCell = @"myAttentionCell";
    MyAttentionCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierOfMyAttentionCell];
    if (cell == nil) {
        cell = [[[UINib nibWithNibName:@"MyAttentionCell" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
        cell.myAttentionImageView.layer.cornerRadius = cell.myAttentionImageView.bounds.size.width*0.5;
        cell.myAttentionImageView.layer.masksToBounds = YES;
        
    }
    return cell;
}

@end
