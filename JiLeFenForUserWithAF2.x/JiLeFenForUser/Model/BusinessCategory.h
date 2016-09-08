//
//  Category.h
//  JiLeFenForUser
//
//  Created by hhy on 16/9/6.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface BusinessCategory : BaseModel
//分类名
@property (nonatomic, copy) NSString *name;
//分类的父类信息，可能有很多，但最少应该有父ID
@property (nonatomic, copy) NSString *parentID;
@end
