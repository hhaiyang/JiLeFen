//
//  DomesticConvertCell.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/5.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "DomesticConvertCell.h"

@implementation DomesticConvertCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    DomesticConvertCell *cell = [tableView dequeueReusableCellWithIdentifier:@"domesticConvertCell"];
    if (cell == nil) {
        cell = [[[UINib nibWithNibName:@"DomesticConvertCell" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
        
    }
    return cell;
}
@end
