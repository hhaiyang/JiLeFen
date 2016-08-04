//
//  ViewUtil.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/23.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ViewUtil.h"

@implementation ViewUtil
+ (UIButton *)closeButtonWithPosition:(CGPoint)position andWidth:(CGFloat)width {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"弹出框关闭小图标"];
    CGFloat height = image.size.height/image.size.width*width;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    button.frame = CGRectMake(position.x, position.y, width, height);
    return button;
}
+ (UIImageView *)successImageViewWithPosition:(CGPoint)position andHeight:(CGFloat)height {
    UIImageView *imageView = [UIImageView new];
    UIImage *image = [UIImage imageNamed:@"成功小图标"];
    CGFloat width = image.size.width/image.size.height*height;
    imageView.image = image;
    imageView.frame = CGRectMake(position.x, position.y, width, height);
    return imageView;
}
+ (UITextField *)textFieldWithOrigin:(CGPoint)origin width:(CGFloat)width placehold:(NSString *)placehold {
    UITextField *textField = [UITextField new];
    textField.placeholder = placehold;
    UIImage *image = [UIImage imageNamed:@"物品兑换-输入兑换码小图标"];
    CGFloat height = image.size.height/image.size.width*width;
    textField.frame = CGRectMake(origin.x, origin.y, width, height);
    textField.background = image;
    return textField;
}
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

@end
