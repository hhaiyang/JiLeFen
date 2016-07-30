//
//  BaseScrollViewController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BaseScrollViewController.h"

@interface BaseScrollViewController ()

@end

@implementation BaseScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIScrollView *tmpMainView = [[UIScrollView alloc] initWithFrame:[self contentViewFrame]];
    tmpMainView.backgroundColor = self.view.backgroundColor;
    tmpMainView.alwaysBounceVertical = YES;
    self.mainView = tmpMainView;
    [self.view addSubview:self.mainView];
}


@end
