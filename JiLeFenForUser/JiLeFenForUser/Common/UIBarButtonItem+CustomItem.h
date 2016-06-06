//
//  UIBarButtonItem+BackItem.h
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/2/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CustomItem)
+ (instancetype)barButtonItemWithTarget:(id)target action:(SEL)action imageName:(NSString *)imageName height:(CGFloat)height;
@end
