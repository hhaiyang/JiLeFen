//
//  MyRelatedAccountController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyRelatedAccountController.h"
#import "RelatedAccountSuccessController.h"

@interface MyRelatedAccountController ()

@end

@implementation MyRelatedAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关联账号";
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回小图标-红色" height:30];

    
    
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)confirm:(id)sender {
    TEST_LOG(@"确定");
    RelatedAccountSuccessController *successController = [RelatedAccountSuccessController new];
    [self.navigationController pushViewController:successController animated:YES];
}
@end
