//
//  LookConvertCodePopView.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "LookConvertCodePopView.h"

@implementation LookConvertCodePopView
+ (instancetype)popView {
    LookConvertCodePopView *view = [[[UINib nibWithNibName:@"LookConvertCodePopView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    view.backgroundColor = [UIColor popColor];
    view.frame = kScreenBounds;
    return view;
}
@end
