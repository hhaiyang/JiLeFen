//
//  User.h
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, copy) NSString *ID;
+ (instancetype)currentUser;
@end
