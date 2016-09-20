//
//  User.h
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

typedef enum UserStatus {
    Login,
    NoLogin
    
}UserStatus;

@interface User : BaseModel
//用户的登录状态
@property (nonatomic, assign) UserStatus status;
//获取当前用户
+ (instancetype)currentUser;

@end
