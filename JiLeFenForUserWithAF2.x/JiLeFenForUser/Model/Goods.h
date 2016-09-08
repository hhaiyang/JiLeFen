//
//  Goods.h
//  JiLeFenForUser
//
//  Created by hhy on 16/9/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
//商品模型
@interface Goods : BaseModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *brief;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *cost;
@end
