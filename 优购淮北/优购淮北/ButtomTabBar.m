//
//  ButtomTabBar.m
//  优购淮北
//
//  Created by 李峰峰 on 15/8/18.
//  Copyright (c) 2015年 李峰峰. All rights reserved.
//

#import "ButtomTabBar.h"
#import "TabBarButton.h"

@interface ButtomTabBar()
@property(nonatomic,weak)TabBarButton *selectedButton;

@end

@implementation ButtomTabBar

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main_navigation_background"]];
        [self addButton];
    }
    return self;
}

-(void)addButton{
    for (int i = 0; i < 4; i++) {
        TabBarButton *button = [TabBarButton buttonWithType:UIButtonTypeCustom];
        NSString *imageName = [NSString stringWithFormat:@"buttomicon%d",i+1];
        NSString *imageNameSelect = [NSString stringWithFormat:@"buttomicon%dselected",i+1];
        [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:imageNameSelect] forState:UIControlStateSelected];
        
        button.tag = i;
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];

        [self addSubview:button];
        
        if (i == 0) {
            [self buttonClick:button];
        }
    }
}

-(void)buttonClick:(TabBarButton *)button{
    
    //通知代理方法
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectButtomFrom:to:)]) {
        [self.delegate tabBar:self didSelectButtomFrom:self.selectedButton.tag to:button.tag];
//        NSLog(@".......");
    }
    
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
//    NSLog([NSString stringWithFormat:@"点击了按钮%d",button.tag]);

}

-(void)layoutSubviews{
    for (int i = 0; i<4; i++) {
        TabBarButton *button = [TabBarButton buttonWithType:UIButtonTypeCustom];
        button = self.subviews[i];
        button.frame = CGRectMake((self.frame.size.width/4)*i, 0, self.frame.size.width/4, self.frame.size.height);
    }
}

@end
