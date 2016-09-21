//
//  AllCategoryController.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeController.h"
#import "Cate.h"

@interface BusinessListController : UIViewController
@property (nonatomic, assign) BusinessType businessType;

@property (nonatomic, strong) Cate *cate;
@end
