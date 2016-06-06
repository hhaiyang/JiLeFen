//
//  ModifyPasswordController.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/2/23.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ModifyPasswordController.h"

@interface ModifyPasswordController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *latestPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;


@end

@implementation ModifyPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicSetup];
    
}
- (void)basicSetup {
    self.title = @"修改登录密码";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(backAction:) imageName:@"二级页面返回小图标" height:30];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}
- (IBAction)confirmModifyPassword:(UIButton *)sender {
    TEST_LOG(@"修改密码");
    
}
- (void)backAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
