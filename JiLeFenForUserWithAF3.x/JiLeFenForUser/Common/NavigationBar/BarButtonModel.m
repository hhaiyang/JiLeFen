//
//  BarButtonModel.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BarButtonModel.h"

@implementation BarButtonModel

-(id)initWithDict:(NSDictionary*)navigatorButtonDict
{
    if (self = [super init])
    {
        NSString *strExist = [navigatorButtonDict objectForKey:@"exist"];
        self.exist = [strExist isEqual:@"true"];
        self.showNo = [navigatorButtonDict objectForKey:@"DoNot"];
        
        if (self.exist)
        {
            self.name = [navigatorButtonDict objectForKey:@"name"];
            self.func = [navigatorButtonDict objectForKey:@"success"];
        }
        else
        {
            self.name = @"";
            self.func = @"";
        }
    }
    return self;
}

@end

@implementation FireflyNavBarModel

-(id)initWithDict:(NSDictionary*)paraDict
{
    if (self = [super init])
    {
        self.title = [paraDict objectForKey:@"title"];
        
        NSDictionary *dictLeftNavButton = [paraDict objectForKey:@"leftButton"];
        self.leftButton = [[BarButtonModel alloc] initWithDict:dictLeftNavButton];
        self.theFunc= self.leftButton.func;
        
        NSDictionary *dictRightNavButton = [paraDict objectForKey:@"rightButton"];
        self.rightButton = [[BarButtonModel alloc] initWithDict:dictRightNavButton];
        self.rightButton = self.rightButton;
    }
    return self;
    
}

@end
