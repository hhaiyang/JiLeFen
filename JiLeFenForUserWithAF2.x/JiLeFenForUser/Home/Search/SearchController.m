//
//  SearchController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "SearchController.h"
#import "UIImage+Resize.h"

@interface SearchController ()
//搜索文本框
@property (nonatomic, strong) UITextField *searchTextField;
@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRGBColor(242, 242, 242);
    //设置导航栏
    //返回按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回按钮" height:30];
    //搜索按钮
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    searchButton.frame = CGRectMake(0, 0, 30, 25);
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setTitleColor:kRGBColor(97, 97, 97) forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    self.navigationItem.rightBarButtonItem = searchItem;
    
    //搜索框
    UIImage *image = [UIImage imageNamed:@"首页搜索框"];
    UIImage *newImage = [image resizeImageWithSize:CGSizeMake(image.size.width/image.size.height*35, 35)];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:newImage];
    imageView.userInteractionEnabled = YES;
    self.navigationItem.titleView = imageView;
    image = [UIImage imageNamed:@"首页搜索框搜索按钮"];
    UIImageView *searchImageView = [[UIImageView alloc] initWithImage:image];
    searchImageView.frame = CGRectMake(5, 5, image.size.width/image.size.height*(imageView.height-10), imageView.height-10);
    [imageView addSubview:searchImageView];
    
    UITextField *textField = [UITextField new];
    _searchTextField = textField;
    textField.font = [UIFont systemFontOfSize:12];
    textField.placeholder = @"请输入商家、分类、地点等";
    textField.frame = CGRectMake(searchImageView.x+searchImageView.width, 0, imageView.width-searchImageView.width-searchImageView.x, imageView.height);
    [imageView addSubview:textField];

    
    //最热搜素标签
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
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)search {
    TEST_LOG(@"搜索");
}
@end
