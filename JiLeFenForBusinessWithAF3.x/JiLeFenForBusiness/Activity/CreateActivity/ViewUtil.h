//
//  ViewUtil.h
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/23.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewUtil : NSObject
+ (UIButton *)closeButtonWithPosition:(CGPoint)position andWidth:(CGFloat)width;
+ (UIImageView *)successImageViewWithPosition:(CGPoint)position andHeight:(CGFloat)height;
+ (UITextField *)textFieldWithOrigin:(CGPoint)origin width:(CGFloat)width placehold:(NSString *)placehold;
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
@end
