//
//  Business.h
//  JiLeFenForUser
//
//  Created by hhy on 16/9/5.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessCategory.h"
#import "BaseModel.h"
//商家模型
@interface Business : BaseModel
//商家的名字
@property (nonatomic, copy) NSString *name;
//商家的地址
@property (nonatomic, copy) NSString *address;
//商家所属分类
@property (nonatomic, strong) BusinessCategory *businessCategory;
@end
