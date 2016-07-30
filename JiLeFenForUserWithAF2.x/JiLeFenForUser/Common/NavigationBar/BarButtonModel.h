//
//  BarButtonModel.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BarButtonModel : NSObject

@property BOOL exist;
@property (nonatomic, copy) NSString *showNo;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *func;

-(id)initWithDict:(NSDictionary*)paraDict;

@end

@interface FireflyNavBarModel : NSObject

@property(nonatomic, copy) NSString * title;
@property(nonatomic, copy) NSString * theFunc;
@property(nonatomic, strong) BarButtonModel * leftButton;
@property(nonatomic, strong) BarButtonModel * rightButton;

-(id)initWithDict:(NSDictionary*)paraDict;

@end
