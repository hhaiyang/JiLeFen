//
//  Business.h
//  JiLeFenForUser
//
//  Created by hhy on 16/9/5.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
//商家模型
@interface Business : NSObject
//商家ID
@property (nonatomic, copy) NSString *ID;
//商家的名字
@property (nonatomic, copy) NSString *name;
//商家的地址
@property (nonatomic, copy) NSString *address;
@end
