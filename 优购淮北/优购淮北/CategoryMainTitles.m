//
//  CategoryTitles.m
//  优购淮北
//
//  Created by 李峰峰 on 15/8/20.
//  Copyright (c) 2015年 李峰峰. All rights reserved.
//

#import "CategoryMainTitles.h"

@implementation CategoryMainTitles


-(NSArray *)mainTitles{
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"CategoryMainTitle.plist" ofType:nil];
    _mainTitles = [NSArray arrayWithContentsOfFile:path];
    return _mainTitles;

}

-(NSMutableArray *)mianImages{
    NSMutableArray *temparray = [NSMutableArray array];
    for (int i = 2; i<=19; i++) {
        NSString *imagename = [NSString stringWithFormat:@"sort_%d",i];
        [temparray addObject:imagename];
    }
    return temparray;

}




@end
