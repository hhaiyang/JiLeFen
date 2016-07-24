//
//  GoodsConvertController.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "GoodsConvertController.h"
#import "CheckCodeController.h"
#import "GoodsListController.h"



@interface GoodsConvertController ()
@property (nonatomic, strong) NSArray *childrenController;
@property (nonatomic, strong) NSArray *titleArr;
@end

@implementation GoodsConvertController
- (NSArray *)titleArr {
    if (_titleArr) {
        return _titleArr;
    }
    _titleArr = @[@"验证兑换码", @"兑换记录"];
    return _titleArr;
}
- (NSArray *)childrenController {
    if (_childrenController) {
        return _childrenController;
    }
    CheckCodeController *checkCode = [CheckCodeController new];
    GoodsListController *goodsList = [GoodsListController new];
    _childrenController = @[checkCode, goodsList];
    return _childrenController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DEFAULT_VIEW_CONTROLLER_BACKGROUND_COLOR;
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(toForwardVC) imageName:@"二级页面返回小图标" height:30];
    self.title = @"物品兑换";
    [self initMenuView];
}
- (void)initMenuView {
    self.menuItemWidth = self.view.width/2;
    self.menuHeight = 50;
    
}
- (void)toForwardVC {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.childrenController.count;
}
- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    return self.childrenController[index];
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titleArr[index];
}

@end
