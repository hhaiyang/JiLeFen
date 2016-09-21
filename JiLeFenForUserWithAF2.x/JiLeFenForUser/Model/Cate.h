//
//  Category.h
//  JiLeFenForUser
//
//  Created by hhy on 16/9/6.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"


@interface Cate : BaseModel
//分类名
@property (nonatomic, copy) NSString *name;
//分类的父类信息
@property (nonatomic, copy) NSString *parentID;
//分类的图标
@property (nonatomic, copy) NSString *icon;
@end
