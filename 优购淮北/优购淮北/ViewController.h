//
//  ViewController.h
//  优购淮北
//
//  Created by 李峰峰 on 15/8/17.
//  Copyright (c) 2015年 李峰峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategoryButtonClickDelegate <NSObject>

@optional
-(void)categoryButtonclicked:(NSInteger)buttonTag;

@optional
-(void)webviewLinkClicked:(NSString *)url;

@end


@interface ViewController : UIViewController

@property(nonatomic,weak)id<CategoryButtonClickDelegate> delegate;

@end

