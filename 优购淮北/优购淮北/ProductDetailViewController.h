//
//  ProductDetailViewController.h
//  优购淮北
//
//  Created by 李峰峰 on 15/8/20.
//  Copyright (c) 2015年 李峰峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProductBackButtonClickDelegate <NSObject>

@optional
-(void)productBackButtonClick;

@end

@interface ProductDetailViewController : UIViewController

@property(nonatomic,strong)NSString *productUrl;
@property(nonatomic,weak)id<ProductBackButtonClickDelegate> delegate;

@end
