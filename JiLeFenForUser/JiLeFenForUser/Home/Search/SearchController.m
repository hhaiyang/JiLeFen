//
//  SearchController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "SearchController.h"

@interface SearchController ()

@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRGBColor(242, 242, 242);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回按钮" height:30];
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    searchButton.frame = CGRectMake(0, 0, 30, 25);
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setTitleColor:kRGBColor(97, 97, 97) forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    self.navigationItem.rightBarButtonItem = searchItem;
    
    UILabel *hotSearchLabel = [UILabel new];
    hotSearchLabel.text = @"最热搜索";
    hotSearchLabel.frame = CGRectMake(30, 81, 100, 21);
    hotSearchLabel.font = [UIFont systemFontOfSize:17];
    hotSearchLabel.textColor = [UIColor grayColor];
    [self.view addSubview:hotSearchLabel];
    
    UIButton *button = nil;
    CGFloat buttonWidth = (self.view.width-40)/3;
    CGFloat buttonHeight = 30;
    for (int buttonIndex = 0; buttonIndex < 9; buttonIndex++) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.layer.cornerRadius = 5;
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:@"首熙足典" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.frame = CGRectMake(buttonIndex%3*(buttonWidth+10)+10, buttonIndex/3*(buttonHeight+10)+hotSearchLabel.y+hotSearchLabel.height+10, buttonWidth, buttonHeight);
        [self.view addSubview:button];
        
        
        
    }
    
    
   
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)search {
    TEST_LOG(@"搜索");
}
@end
