//
//  HYBarButtonItem.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "HYBarButtonItem.h"
#import "ImageManager.h"

@implementation HYBarButtonItem

- (id)initBackWithTarget:(id)target action:(SEL)action
{
    if (self = [super init])
    {
        self.target = target;
        self.action = action;
        self.style = PPBarButtonItemStyleBack;
        self.image = [ImageManager imageNamed:@"common_UI_navbar_back"];
        self.imageHighlight = [ImageManager imageNamed:@"common_UI_navbar_back"];
    }
    
    return self;
}

-(id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    if (self = [super init])
    {
        
        self.target = target;
        self.action = action;
        self.style = PPBarButtonItemStyleCustom;
        
        if ([title isEqualToString:NAVBAR_HOME])
        {
            self.image =nil;
            self.imageHighlight = nil;
            
        }
        else if ([title isEqual:NAVBAR_HELP])
        {
            self.image =[ImageManager imageNamed:@"common_UI_navbar_info"];
            self.imageHighlight =[ImageManager imageNamed:@"common_UI_navbar_info"];
            
        }
        else if ([title isEqual:NAVBAR_SHARE])
        {
            self.image = [ImageManager imageNamed:@"common_UI_navbar_share_nor"];
            self.imageHighlight = [ImageManager imageNamed:@"common_UI_navbar_share_nor"];
        }
        else
        {
            self.title = title;
            self.image = nil;
            self.imageHighlight = nil;
        }
    }
    return self;
}

@end
