//
//  BaseViewController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "HYBaseViewController.h"

@interface HYBaseViewController ()

- (void)setDefaultLayout;

@end

@implementation HYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setDefaultLayout];
    self.view.backgroundColor = VIEWCONTROLLERBACKGROUNDCOLOR;
    
    if (!self.isNavbarHidden)
    {
        [self initNavBarView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGRect)contentViewFrame
{
    CGFloat gapY;
    if (self.isNavbarHidden)
    {
        gapY = 0;
    }
    else
    {
        gapY = self.navBarView.frame.size.height;
    }
    
    CGRect tmpFrame = CGRectMake(0,
                                 gapY,
                                 kScreenHeight,
                                 kScreenHeight - gapY);
    
    return tmpFrame;
}

- (void)initNavBarView
{
    HYNavigationBar *tmpNavBarView = [[HYNavigationBar alloc] initWithFrame:NAV_BAR_FRAME];
    self.navBarView = tmpNavBarView;
    
    [self.view addSubview:self.navBarView];
}

#pragma mark - private method
- (void)setDefaultLayout
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
    if (IOS6_OR_EARLIER)
    {
        self.view.frame = CGRectMake(0, 0,
                                     self.view.bounds.size.width,
                                     self.view.bounds.size.height);
    }
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (IOS7_OR_LATER)
    {
        return UIStatusBarStyleLightContent;
    }
    else
    {
        return UIStatusBarStyleBlackOpaque;
    }
}

#pragma mark - viewController rotate method
- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationPortrait;
}

#pragma mark - Navigation Item
- (HYBarButtonItem *)backButtonItem
{
    return [[HYBarButtonItem alloc] initBackWithTarget:self action:@selector(doNavigationBack)];
}

- (void)doNavigationBack
{
    if(self.navigationController)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
