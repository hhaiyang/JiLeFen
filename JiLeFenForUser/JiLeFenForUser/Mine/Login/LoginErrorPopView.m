//
//  NoRegisterPopView.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "LoginErrorPopView.h"

@implementation LoginErrorPopView

+ (instancetype)loginErrorPopView {
    LoginErrorPopView *view = [[[UINib nibWithNibName:@"LoginErrorPopView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    view.contentView.layer.cornerRadius = 5;
    view.contentView.layer.masksToBounds = YES;
    
    view.backgroundColor = [UIColor popColor];
    return view;
}

@end
