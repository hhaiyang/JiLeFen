//
//  SuspendView.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "SuspendView.h"

@implementation SuspendView

+ (instancetype)suspendView {
    SuspendView *view = [[[UINib nibWithNibName:@"SuspendView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    view.backgroundColor = kRGBAColor(73, 73, 73, 0.6);
    return view;
}
@end
