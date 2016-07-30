//
//  AddScoreController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AddScoreController.h"
#import "QRCodeScoreController.h"
#import "QRCodeGenerator.h"
#import "QRCodeController.h"
#import "ScoreRecordController.h"
#import "WMPageConst.h"

@interface AddScoreController ()
@property (nonatomic, strong) NSArray *childrenController;
@end

@implementation AddScoreController

- (NSArray *)childrenController {
    if (_childrenController) {
        return _childrenController;
    }
    QRCodeController *qrcode = [QRCodeController new];
    ScoreRecordController *scoreRecord = [ScoreRecordController new];
    _childrenController = @[qrcode, scoreRecord];
    return _childrenController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
      self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回小图标-红色" height:30];
    self.menuHeight = 55;
    self.menuItemWidth = self.view.width/2;
    self.postNotification = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controllerDidAddToSuperViewNotification:) name:WMControllerDidAddToSuperViewNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)controllerDidAddToSuperViewNotification:(NSNotification *)noti {
    self.title = noti.object[@"title"];
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.childrenController.count;
}
- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    return self.childrenController[index];
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return @[@"增加积分", @"积分明细"][index];
}
@end
