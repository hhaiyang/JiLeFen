//
//  MineHeaderView.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MineHeaderView.h"

@implementation MineHeaderView

+ (instancetype)headerView {
    MineHeaderView *view = [[UINib nibWithNibName:@"MineHeaderView" bundle:nil] instantiateWithOwner:nil options:nil][0];
    return view;
}

@end
