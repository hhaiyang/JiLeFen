//
//  CategorySubTitles.m
//  优购淮北
//
//  Created by 李峰峰 on 15/8/21.
//  Copyright (c) 2015年 李峰峰. All rights reserved.
//

#import "CategorySubTitles.h"

@implementation CategorySubTitles


-(NSArray *)subTitle{

    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"CategoryTitles.plist" ofType:nil];
    _subTitle = [NSArray arrayWithContentsOfFile:path];
    return _subTitle;
}

@end
