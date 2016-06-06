//
//  RegisterController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "RegisterController.h"

@interface RegisterController ()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.navigationItem.leftBarButtonItem = [ViewUtil whiteBackItemWithTarget:self action:@selector(toForwardVC)];
    
    UIImageView *backgroundImageView = [UIImageView new];
    self.backgroundImageView = backgroundImageView;
    backgroundImageView.frame = self.view.bounds;
    backgroundImageView.image = [UIImage imageNamed:@"RegisterBackground"];
    [self.view addSubview:backgroundImageView];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"RegisterBackground"] forBarMetrics:UIBarMetricsDefault];
    
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];

}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


- (void)toForwardVC {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)beginRegister:(id)sender {
    TEST_LOG(@"开始注册");
}



@end
