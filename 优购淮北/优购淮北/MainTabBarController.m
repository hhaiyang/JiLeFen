//
//  MainTabBarController.m
//  优购淮北
//
//  Created by 李峰峰 on 15/8/18.
//  Copyright (c) 2015年 李峰峰. All rights reserved.
//

#import "MainTabBarController.h"
#import "ButtomTabBar.h"
#import "ViewController.h"
#import "ProductDetailViewController.h"
#import "CategoryViewController.h"
#import "MyViewController.h"
#import "ActivityViewController.h"
#import "MoreViewController.h"


@interface MainTabBarController ()<ButtomTabBarDelegate,CategoryButtonClickDelegate,ProductBackButtonClickDelegate,CategoryUrlDelegate>

@property(nonatomic,strong)ProductDetailViewController *productController;


@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addViewController];
    [self addTabBar];

}

-(void)addViewController{
    
    //添加home控制器（首页）
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ViewController"  bundle:nil];
    ViewController *homeViewController = [storyboard instantiateInitialViewController];
    //设置代理
    homeViewController.delegate = self;
    [self addChildViewController:homeViewController];
    
    //添加my控制器（我的）
    UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"MyViewController" bundle:nil];
    MyViewController *myViewController = [mystoryboard instantiateInitialViewController];
    [self addChildViewController:myViewController];
    
    //添加activity控制器（活动）
    UIStoryboard *activitystoryboard = [UIStoryboard storyboardWithName:@"ActivityViewController" bundle:nil];
    ActivityViewController *activityViewController = [activitystoryboard instantiateInitialViewController];
    [self addChildViewController:activityViewController];
    
    //添加MoreViewController控制器（更多）
    UIStoryboard *morestoryboard = [UIStoryboard storyboardWithName:@"MoreViewController" bundle:nil];
    MyViewController *moreViewController = [morestoryboard instantiateInitialViewController];
    [self addChildViewController:moreViewController];
    
    //添加ProductDetailViewController控制器（活动详情／商家详情）
    UIStoryboard *webviewStoryBoard = [UIStoryboard storyboardWithName:@"ProductDetailViewController" bundle:nil];
    ProductDetailViewController *productDetailViewController = [webviewStoryBoard instantiateInitialViewController];
    self.productController = productDetailViewController;
    productDetailViewController.delegate = self;
    [self addChildViewController:productDetailViewController];
    
    //添加CategoryViewController控制器（分类信息）
    UIStoryboard *categoryStroyboard = [UIStoryboard storyboardWithName:@"CategoryViewController" bundle:nil];
    CategoryViewController *categoryViewController = [categoryStroyboard instantiateInitialViewController];
    [self addChildViewController:categoryViewController];
    categoryViewController.delegate = self;
    
    
    
    

}

-(void)addTabBar{
    
    [self.tabBar removeFromSuperview];
    ButtomTabBar *buttomTabBar = [[ButtomTabBar alloc]initWithFrame:self.tabBar.frame];
    //设置代理
    buttomTabBar.delegate = self;
    [self.view addSubview:buttomTabBar];
    

}

#pragma mark-自定义的ProductBackButtonClickDelegate中的方法
-(void)productBackButtonClick{
    self.selectedIndex = 0;
}


#pragma mark-自定义的ButtomTabBarDelegate代理协议中的方法

-(void)tabBar:(ButtomTabBar *)tabBar didSelectButtomFrom:(NSInteger)from to:(NSInteger)to{
    self.selectedIndex = to;

}

#pragma mark-自定义的categoryButtonclickDelegate代理协议中的方法
-(void)categoryButtonclicked:(NSInteger)buttonTag{
    NSInteger selectItem;
    NSString *url = [[NSString alloc]init];
    switch (buttonTag) {
        case 0:
            selectItem = 4;
            url = @"http://www.ugohb.com/client/diszhe.php?did=1";
            break;
            
        case 1:
            selectItem = 4;
            url = @"http://www.ugohb.com/client/catelist.php?id=3";
            break;
            
        case 2:
            selectItem = 4;
            url = @"http://www.ugohb.com/client/diszhe.php?did=3";
            break;
            
        case 3:
            selectItem = 4;
            url = @"http://www.ugohb.com/client/catelist.php?id=4";
            break;
            
        case 4:
            selectItem = 4;
            url = @"http://www.ugohb.com/client/catelist.php?id=196";
            break;
            
        case 5:
            selectItem = 4;
            url = @"http://www.ugohb.com/client/catelist2.php?id=2";
            break;
            
        case 6:
            selectItem = 4;
            url = @"http://www.ugohb.com/client/catelist2.php?id=197";
            break;
            
        case 7:
            selectItem = 5;
            break;

    }
    self.selectedIndex = selectItem;
    self.productController.productUrl = url;
}

-(void)webviewLinkClicked:(NSString *)url{

    self.selectedIndex = 4;
    self.productController.productUrl = url;
    
}
//CategoryUrlDelegate的代理方法
-(void)click:(NSString *)url{
    self.selectedIndex = 4;
    self.productController.productUrl = url;
}

@end


















