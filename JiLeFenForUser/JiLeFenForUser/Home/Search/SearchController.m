//
//  SearchController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "SearchController.h"

@interface SearchController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *hotSearchButtons;

@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
   
}
- (void)initUI {
    self.view.backgroundColor = kRGBColor(242, 242, 242);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回按钮" height:30];
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    searchButton.frame = CGRectMake(0, 0, 30, 25);
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setTitleColor:kRGBColor(97, 97, 97) forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    self.navigationItem.rightBarButtonItem = searchItem;
    
    for (UIButton *button in self.hotSearchButtons) {
        button.layer.cornerRadius = 5;
    }
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)search {
    TEST_LOG(@"搜索");
}
@end
