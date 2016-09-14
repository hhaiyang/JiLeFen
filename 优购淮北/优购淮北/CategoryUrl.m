//
//  CategoryUrl.m
//  优购淮北
//
//  Created by 优购淮北 on 15/9/3.
//  Copyright (c) 2015年 李峰峰. All rights reserved.
//

#import "CategoryUrl.h"

@implementation CategoryUrl


-(NSArray *)categoryUrl{
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"categoryurl.plist" ofType:nil];
    _categoryUrl = [NSArray arrayWithContentsOfFile:path];
    return _categoryUrl;
}



@end
