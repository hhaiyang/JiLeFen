//
//  ResManager.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResManager : NSObject
+ (ResManager *)sharedInstance;

/**
 *  返回图片key对应的图片路径
 *
 *  @param imageKey 图片的key,参见resconfig.plist
 *
 *  @return imageKey对应的图片路径
 */
- (NSString *)pathForImage:(NSString *)imageKey;
@end
