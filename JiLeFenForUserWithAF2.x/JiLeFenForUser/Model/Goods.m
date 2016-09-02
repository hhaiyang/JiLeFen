//
//  Goods.m
//  JiLeFenForUser
//
//  Created by hhy on 16/9/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Goods.h"

@implementation Goods
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"ID"]) {
        _ID = key;
    }
}
@end
