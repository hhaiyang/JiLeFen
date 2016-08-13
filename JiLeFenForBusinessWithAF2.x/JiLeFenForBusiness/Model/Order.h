//
//  Order.h
//  JiLeFenForBusiness
//
//  Created by tomcat on 16/8/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Goods.h"

@interface Order : NSObject
@property (nonatomic, strong) Goods *goods;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *count;
@end
