//
//  ImageManager.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageManager : NSObject
/**
 *  非cache的形式，加载图片
 *
 *  @param imageKey 图片资源的key值
 *
 *  @return 返回imageKey对应的UIIMage
 */
+ (UIImage *)imageNamed:(NSString *)imageKey;

/**
 *  非cache的形式，加载图片,根据参数作拉伸
 *
 *  @param imageKey   图片资源的key值
 *  @param imageInset 拉伸的区域
 *
 *  @return 返回拉伸后的UIIMage
 */
+ (UIImage *)imageNamed:(NSString *)imageKey resize:(UIEdgeInsets)imageInset;


/**
 *  将图片保存到系统相册
 *
 *  @param aImage aImage description
 */
+ (void)saveImageToPhotosAlbum:(UIImage *)aImage;

/**
 *  压缩图片
 *
 *  @param sourceImage 压缩前的image
 *  @param aSize       制定压缩后的最大值(单位K)
 *
 *  @return 压缩后的image
 */
+ (UIImage *)compressImage:(UIImage *)sourceImage toSize:(CGFloat)aSize;


@end
