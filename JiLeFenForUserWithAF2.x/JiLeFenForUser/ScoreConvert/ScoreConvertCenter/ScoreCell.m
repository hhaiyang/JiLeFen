//
//  ScoreCell.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ScoreCell.h"

@implementation ScoreCell
+ (instancetype)scoreCellWithTableView:(UITableView *)tableView {
    static NSString *reuseIdentifierOfScoreCell = @"scoreCell";
    ScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierOfScoreCell];
    if (cell == nil) {
        cell = [[[UINib nibWithNibName:@"ScoreCell" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    }
    return cell;
}


@end
