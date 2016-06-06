//
//  UIDevice+Addition.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Addition)
/**
 *  获取设备标识符
 *
 *  @return iOS6以及之后的版本返回IDFA，之前的版本返回OpenUDID
 */
- (NSString *)deviceIdentifier;
@end
