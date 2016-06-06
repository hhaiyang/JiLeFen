//
//  CategoryView.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MiddleView.h"

@implementation MiddleView

+ (instancetype)middleView {
    MiddleView *view = [[[UINib nibWithNibName:@"MiddleView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    return view;
}

@end
