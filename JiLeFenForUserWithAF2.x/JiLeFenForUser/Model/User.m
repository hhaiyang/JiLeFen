//
//  User.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "User.h"
static User *currentUser = nil;

@implementation User
+ (instancetype)currentUser {
    if (currentUser) {
        return currentUser;
    }
    currentUser = [User new];
    currentUser.ID = nil;
    currentUser.status = NoLogin;
    return currentUser;
}
@end
