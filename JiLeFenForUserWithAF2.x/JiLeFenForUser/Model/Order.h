//
//  Order.h
//  JiLeFenForUser
//
//  Created by hhy on 16/9/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
//订单
@interface Order : BaseModel
//交易的用户信息，可能会有很多，但最少应该有用户ID
@property (nonatomic, copy) NSString *userID;
//交易的商家信息，可能会有很多，但最少应该有商家ID
@property (nonatomic, copy) NSString *businessID;
//交易的商品信息，可能会有很多，但最少应该有商品ID
@property (nonatomic, copy) NSString *goodsID;
@end
