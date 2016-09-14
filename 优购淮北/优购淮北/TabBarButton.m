//
//  TabBarButton.m
//  优购淮北
//
//  Created by 李峰峰 on 15/8/18.
//  Copyright (c) 2015年 李峰峰. All rights reserved.
//

#import "TabBarButton.h"

@implementation TabBarButton

-(void)setHighlighted:(BOOL)highlighted{

}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
    
        self.imageView.contentMode = UIViewContentModeCenter;
        
//        [self setBackgroundImage:[UIImage imageNamed:@"buttomButtonSelectedBg"] forState:UIControlStateSelected];
    }
    return self;
    
}

@end
