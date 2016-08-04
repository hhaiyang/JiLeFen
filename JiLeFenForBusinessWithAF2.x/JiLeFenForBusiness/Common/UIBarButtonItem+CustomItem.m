//
//  UIBarButtonItem+BackItem.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/2/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "UIBarButtonItem+CustomItem.h"
#import "UIImage+Resize.h"

@implementation UIBarButtonItem (CustomItem)
+ (instancetype)barButtonItemWithTarget:(id)target action:(SEL)action imageName:(NSString *)imageName height:(CGFloat)height {
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat width = image.size.width / image.size.height * height;
    image = [[image resizeImageWithSize:CGSizeMake(width, height)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return [[self alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
}
@end
