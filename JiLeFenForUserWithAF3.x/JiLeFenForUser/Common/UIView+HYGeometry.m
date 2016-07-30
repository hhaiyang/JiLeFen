//
//  UIView+HYGeometry.m
//  CoreRefresh
//
//  Created by huanghaiyang on 16/3/29.
//  Copyright © 2016年 huanghaiyang. All rights reserved.
//

#import "UIView+HYGeometry.h"

@implementation UIView (HYGeometry)
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x {
    return self.frame.origin.x;
}
- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y {
    return self.frame.origin.y;
}
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size {
    return self.frame.size;
}
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGPoint)origin {
    return self.frame.origin;
}
- (void)setBoundsX:(CGFloat)boundsX {
    CGRect bounds = self.bounds;
    bounds.origin.x = boundsX;
    self.bounds = bounds;
}
- (CGFloat)boundsX {
    return self.bounds.origin.x;
}
- (void)setBoundsY:(CGFloat)boundsY {
    CGRect bounds = self.bounds;
    bounds.origin.y = boundsY;
    self.bounds = bounds;
}
- (CGFloat)boundsY {
    return self.bounds.origin.y;
}
@end
