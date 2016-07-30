//
//  TabBarController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TabBarController.h"
#import "MineController.h"
#import "ScoreConvertCenterController.h"
#import "HomeController.h"


@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicSetup];
    [self createViewControllers];
    
}
- (void)basicSetup {
    self.tabBar.barTintColor = kRGBColor(223, 25, 61);
    self.tabBar.tintColor = [UIColor whiteColor];
}
- (void)createViewControllers {
    HomeController *homeController = [HomeController new];
    UINavigationController *homeNavi = [[UINavigationController alloc] initWithRootViewController:homeController];
    MineController *mineController = [[MineController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *mineNavi = [[UINavigationController alloc] initWithRootViewController:mineController];
    
    ScoreConvertCenterController *scoreController = [ScoreConvertCenterController new];
    UINavigationController *scoreNavi = [[UINavigationController alloc] initWithRootViewController:scoreController];
    
    self.viewControllers = @[homeNavi, mineNavi, scoreNavi];
    
}
@end
