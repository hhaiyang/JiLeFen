//
//  UIImage+Resize.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/2/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)
- (UIImage *)resizeImageWithSize:(CGSize)size {
    UIImage *image = nil;
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
