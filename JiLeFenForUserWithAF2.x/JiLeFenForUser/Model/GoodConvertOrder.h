//
//  GoodConvertOrder.h
//  JiLeFenForUser
//
//  Created by hhy on 16/9/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Order.h"
//物品兑换订单
@interface GoodConvertOrder : Order
//兑换该物品原来的价格
@property (nonatomic, copy) NSString *price;
//兑换该物品实际的花费，因为是用积分兑换，所以也就是实际花费的积分
@property (nonatomic, copy) NSString *cost;
//兑换的时间
@property (nonatomic, copy) NSString *timestamp;
@end
