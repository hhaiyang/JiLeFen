//
//  ViewUtil.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/6/6.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewUtil.h"

#define BackItemHeight 30

@implementation ViewUtil
+ (UIBarButtonItem *)whiteBackItemWithTarget:(id)target action:(SEL)action {
    return [UIBarButtonItem barButtonItemWithTarget:target action:action imageName:@"返回小图标-白色" height:BackItemHeight];
}
@end
