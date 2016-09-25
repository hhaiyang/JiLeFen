//
//  HomeController.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    //积分
    BusinessTypeDiscount,
    //商超
    BusinessTypeSupermarket,
    //服装
    BusinessTypeClothes,
    //家具
    BusinessTypeFurniture,
    //房产
    BusinessTypeProperty,
    //建材
    BusinessTypeMaterial,
   //全部
    BusinessTypeAll
} BusinessType;

@interface HomeController : UIViewController

@end
