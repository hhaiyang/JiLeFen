//
//  CategoryViewController.h
//  优购淮北
//
//  Created by 李峰峰 on 15/8/20.
//  Copyright (c) 2015年 李峰峰. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CategoryUrlDelegate <NSObject>
@optional
-(void)click:(NSString *)url;

@end


@interface CategoryViewController : UIViewController

@property(nonatomic,weak) id<CategoryUrlDelegate> delegate;

@end
