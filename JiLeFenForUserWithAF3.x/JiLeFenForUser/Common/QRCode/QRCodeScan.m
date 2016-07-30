//
//  QRCodeScan.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QRCodeScan.h"
#import "ZBarReaderController.h"

@implementation QRCodeScan

+ (NSString *)decodeFromQRImage:(UIImage *)qrImage;
{
    ZBarSymbol *symbol = nil;
    ZBarReaderController *read = [ZBarReaderController new];
    CGImageRef cgImageRef = qrImage.CGImage;
    
    for(symbol in [read scanImage:cgImageRef])
        break;
    
    if ([symbol.data canBeConvertedToEncoding:NSShiftJISStringEncoding])
    {
        const char *tmpDecodeData = [symbol.data cStringUsingEncoding: NSShiftJISStringEncoding];
        NSString *tmpQRString = [NSString stringWithCString:tmpDecodeData
                                                   encoding:NSUTF8StringEncoding];
        if (tmpQRString)
        {
            return tmpQRString;
        }
        else
        {
            return symbol.data;
        }
    }
    else
    {
        return symbol.data;
    }
}

+ (UIImage *)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    if (!colorSpace)
    {
        return nil;
    }
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    size_t bufferSize = CVPixelBufferGetDataSize(imageBuffer);
    
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, baseAddress, bufferSize,NULL);
    CGImageRef cgImage =
    CGImageCreate(width,
                  height,
                  8,
                  32,
                  bytesPerRow,
                  colorSpace,
                  kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder32Little,
                  provider,
                  NULL,
                  true,
                  kCGRenderingIntentDefault);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    return image;
}

@end
