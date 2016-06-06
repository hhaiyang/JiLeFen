//
//  RelatedAccountSuccessController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "RelatedAccountSuccessController.h"
#import "CancelRelatePopView.h"

@interface RelatedAccountSuccessController ()
@property (nonatomic, strong) CancelRelatePopView *popView;
@end

@implementation RelatedAccountSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
   
}

- (void)initUI {
    self.title = @"关联账号";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回小图标-红色" height:30];
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelRelate:(id)sender {
    CancelRelatePopView *popView = [CancelRelatePopView popView];
    [popView.closeButton addTarget:self action:@selector(closePopView) forControlEvents:UIControlEventTouchUpInside];
    [popView.confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [popView.cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    self.popView = popView;
    [kWindow addSubview:popView];
}
- (void)closePopView {
    [self.popView removeFromSuperview];
    self.popView = nil;
}
- (void)confirm {
    [self closePopView];
}
- (void)cancel {
    [self closePopView];
}

@end
