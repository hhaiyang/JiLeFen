//
//  NSDictionary+Decription.m
//
//
//  Created by huanghaiyang on 16/1/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "NSDictionary+Decription.h"

@implementation NSDictionary (Decription)
- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [str appendFormat:@"\t%@:%@\n",key,obj];
    }];
    [str appendString:@"}\n"];
    return str;
}
@end
