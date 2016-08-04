//
//  NSArray+Description.m
//  
//
//  Created by huanghaiyang on 16/1/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "NSArray+Description.h"

@implementation NSArray (Description)
- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"[\n"];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [str appendFormat:@"\t%@\n", obj];
    }];
    [str appendString:@"]\n"];
    return str;
}

@end
