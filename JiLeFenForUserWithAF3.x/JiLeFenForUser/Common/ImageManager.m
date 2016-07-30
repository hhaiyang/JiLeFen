//
//  ImageManager.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ImageManager.h"
#import "ResManager.h"

@implementation ImageManager
+ (UIImage *)imageNamed:(NSString *)imageKey
{
    NSString *imagePath = [[ResManager sharedInstance] pathForImage:imageKey];
    UIImage *tmpImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
    if (tmpImage == nil)
    {
        imagePath = [imagePath stringByReplacingOccurrencesOfString:@".png" withString:@"@2x.png"];
        tmpImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
        
    }
    return tmpImage;
}

+ (UIImage *)imageNamed:(NSString *)imageKey resize:(UIEdgeInsets)imageInset
{
    return [[[self class] imageNamed:imageKey] resizableImageWithCapInsets:imageInset];
}


+ (void)saveImageToPhotosAlbum:(UIImage *)aImage
{
    if (aImage)
    {
        UIImageWriteToSavedPhotosAlbum(aImage, nil, nil, nil);
    }
}

+ (UIImage *)compressImage:(UIImage *)sourceImage toSize:(CGFloat)aSize
{
    CGFloat factor = 1.0f;
    NSData *data = UIImageJPEGRepresentation(sourceImage, factor);
    while (data.length / 1024  > aSize)
    {
        factor -= 0.05f;
        if (factor <= 0.0f) {
            break;
        }
        data = UIImageJPEGRepresentation(sourceImage, factor);
    }
    UIImage *newImage = [UIImage imageWithData:UIImageJPEGRepresentation(sourceImage, factor)];
    return newImage;
}

@end
