//
//  RocationImage.m
//  优购淮北
//
//  Created by 李峰峰 on 15/8/17.
//  Copyright (c) 2015年 李峰峰. All rights reserved.
//

#import "RocationImage.h"
//#import "SDImageCache.h"

@implementation RocationImage

////重写_imagesArray的getter方法
//-(NSMutableArray *)imagesArray{
//    int imageCount = 0;
//    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
//    for (int i = 0; i < imageCount; i++) {
//        NSString *name = [NSString stringWithFormat:@"%02d",i+1];
//        [tempArray addObject:name];
//    }
//    return tempArray;
//}

-(void)initWithString:(NSString *)stringName{
    self.imageName = stringName;
    
}

@end
