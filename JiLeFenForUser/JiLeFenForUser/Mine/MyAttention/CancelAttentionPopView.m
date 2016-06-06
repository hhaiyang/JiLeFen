//
//  CancelAttentionPopView.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CancelAttentionPopView.h"

@implementation CancelAttentionPopView
+ (instancetype)cancelAttentionPopView {
    CancelAttentionPopView *cancelAttentionPopView = [[[UINib nibWithNibName:@"CancelAttentionPopView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    cancelAttentionPopView.backgroundColor = [UIColor popColor];
    cancelAttentionPopView.frame = kScreenBounds;
    return cancelAttentionPopView;
}
@end
