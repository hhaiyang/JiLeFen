//
//  User.h
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum UserStatus {
    Login,
    NoLogin
    
}UserStatus;

@interface User : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, assign) UserStatus status;
+ (instancetype)currentUser;
@end
