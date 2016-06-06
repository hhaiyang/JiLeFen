//
//  HYBarButtonItem.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LEFT_BUTTON_SHOWNO @"showNo"

#define NAVBAR_HOME  @"home"
#define NAVBAR_HELP  @"help"
#define NAVBAR_SHARE @"share"

typedef NS_ENUM(NSInteger, FireflyBarButtonItemStyle)
{
    PPBarButtonItemStyleBordered = 0,
    PPBarButtonItemStyleBack,
    PPBarButtonItemStyleCustom,
};

@interface HYBarButtonItem : NSObject

@property (nonatomic, copy) NSString *title;  //标题
@property (nonatomic, strong) UIImage *image; //背景
@property (nonatomic, strong) UIImage *imageHighlight;  //高亮背景
@property (nonatomic) SEL action;
@property (nonatomic, strong) id target;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) FireflyBarButtonItemStyle style;

- (id)initBackWithTarget:(id)target action:(SEL)action;
- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end

