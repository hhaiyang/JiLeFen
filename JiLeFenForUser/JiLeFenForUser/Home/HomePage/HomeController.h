//
//  HomeController.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    BusinessTypeIntegral,
    BusinessTypeDiscount,
    BusinessTypeShangChao,
    BusinessTypeOther,
    BusinessTypeAll
} BusinessType;

@interface HomeController : UITableViewController

@end
