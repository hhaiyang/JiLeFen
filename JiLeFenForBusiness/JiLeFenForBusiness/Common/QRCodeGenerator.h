//
//  HYQRCodeGenerator.h
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/2/24.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 二维码生成器 */
@interface QRCodeGenerator : NSObject
/**
 *  通过字符串生成二维码图片
 *
 *  @param string 生成二维码的字符串
 *  @param size   二维码图片的尺寸 size*size
 *
 *  @return 二维码image
 */
+ (UIImage *)qrImageForString:(NSString *)aString imageSize:(CGFloat)aSize;
@end
