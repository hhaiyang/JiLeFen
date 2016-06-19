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
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关联账号";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回小图标-红色" height:30];
    
    UIImageView *middleImageView = [UIImageView new];
    middleImageView.frame = CGRectMake((self.view.width-20)/2, 150, 20, 10);
    middleImageView.image = [UIImage imageNamed:@"标志"];
    [self.view addSubview:middleImageView];
    
    UIImageView *leftImageView = [UIImageView new];
    leftImageView.image = [UIImage imageNamed:@"标志"];
    leftImageView.frame = CGRectMake(middleImageView.x-54-3, 0, 54, 54);
    CGPoint center = leftImageView.center;
    center.y = middleImageView.center.y;
    leftImageView.center = center;
    [self.view addSubview:leftImageView];
    
    UIImageView *rightImageView = [UIImageView new];
    rightImageView.image = [UIImage imageNamed:@"标志"];
    rightImageView.frame = CGRectMake(middleImageView.x+middleImageView.width+3, leftImageView.y, leftImageView.width, leftImageView.height);
    [self.view addSubview:rightImageView];
    
    UILabel *hintLabel = [UILabel new];
    hintLabel.frame = CGRectMake(10, leftImageView.y+leftImageView.height+28, self.view.width-20, 35);
    hintLabel.text = @"您与139*******7已互为关联";
    hintLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:hintLabel];
    
    UIButton *freeRelateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat freeRelateButtonHeight = 40;
    UIImage *freeRelateImage = [UIImage imageNamed:@"解除关联按钮"];
    [freeRelateButton setBackgroundImage:freeRelateImage forState:UIControlStateNormal];
    CGFloat freeRelateButtonWidth = freeRelateImage.size.width/freeRelateImage.size.height*freeRelateButtonHeight;
    freeRelateButton.frame = CGRectMake((self.view.width-freeRelateButtonWidth)/2, hintLabel.y+hintLabel.height+30, freeRelateButtonWidth, freeRelateButtonHeight);
    [freeRelateButton addTarget:self action:@selector(cancelRelate:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:freeRelateButton];
   
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelRelate:(id)sender {
    CancelRelatePopView *popView = [CancelRelatePopView new];
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
    __weak typeof(self) weakSelf = self;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
    hud.label.text = @"解除中，请稍候";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"解除成功";
        [hud hideAnimated:YES afterDelay:1.5];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_popView removeFromSuperview];
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
        });
    });
}
- (void)cancel {
    [self closePopView];
}

@end
