//
//  AccountValidate.h
//  Elearning
//
//  Created by huanghaiyang on 16/4/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountValidate : NSObject
+ (BOOL)validateEmail:(NSString*)email;
+ (BOOL)validatePhone:(NSString*)phone;
@end
