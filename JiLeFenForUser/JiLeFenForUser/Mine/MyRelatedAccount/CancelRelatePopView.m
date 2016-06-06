//
//  CancelRelatePopView.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CancelRelatePopView.h"

@implementation CancelRelatePopView

+ (instancetype)popView {
    CancelRelatePopView *popView = [[[UINib nibWithNibName:@"CancelRelatePopView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    popView.frame = kScreenBounds;
    popView.backgroundColor = [UIColor popColor];
    return popView;
}

@end
