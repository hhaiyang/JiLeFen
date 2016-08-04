//
//  HYQRCodeGenerator.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/2/24.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QRCodeGenerator.h"

@implementation QRCodeGenerator
+ (UIImage *)qrImageForString:(NSString *)aString imageSize:(CGFloat)aSize{
    UIImage *image = nil;
    CIImage *ciImage = [self createQRForString:aString];
    CGRect extent = CGRectIntegral(ciImage.extent);
    CGFloat scale = MIN(aSize/CGRectGetWidth(extent), aSize/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    image = [UIImage imageWithCGImage:scaledImage];
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGImageRelease(scaledImage);
    CGColorSpaceRelease(cs);
    return image;
}
+ (CIImage *)createQRForString:(NSString *)qrString {
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // 创建filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 设置内容和纠错级别
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // 返回CIImage
    return qrFilter.outputImage;
}
@end
