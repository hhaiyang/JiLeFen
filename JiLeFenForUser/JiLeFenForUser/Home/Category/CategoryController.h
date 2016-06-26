//
//  AllCategoryController.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeController.h"

@interface CategoryController : UIViewController
@property (nonatomic, assign) BusinessType businessType;
@property (nonatomic, strong) NSArray *sectionTitles;
@end
