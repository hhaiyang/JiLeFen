//
//  ScoreConvertHeaderView.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ScoreConvertHeaderView.h"

@implementation ScoreConvertHeaderView

+ (instancetype)headerView {
    ScoreConvertHeaderView *view = [[[UINib nibWithNibName:@"ScoreConvertHeaderView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    TEST_LOG(@"frame = %@", NSStringFromCGRect(view.frame));
    return view;
}

@end
