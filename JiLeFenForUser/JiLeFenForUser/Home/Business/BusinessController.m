//
//  MerchantController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BusinessController.h"

@interface BusinessController ()
@property (nonatomic, strong) UIImageView *businessImageView;
@property (nonatomic, strong) UIImageView *pointImageView;
@property (nonatomic, strong) UILabel *businessNameLabel;
@property (nonatomic, strong) UILabel *telLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *businessIntroLabel;
@end

@implementation BusinessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"金香蕉";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回按钮" height:30];
    
    _businessImageView = [UIImageView new];
    _businessImageView.backgroundColor = [UIColor whiteColor];
    _businessImageView.image = [UIImage imageNamed:@"标志"];
    _businessImageView.frame = CGRectMake(0, 64, self.view.width, 110);
    [self.view addSubview:_businessImageView];
    
    UIView *line = [UIView new];
    line.frame = CGRectMake(0, _businessImageView.y+_businessImageView.height, self.view.width, 1);
    line.backgroundColor = kRGBColor(235, 232, 231);
    [self.view addSubview:line];
    
    _pointImageView = [UIImageView new];
    _pointImageView.image = [UIImage imageNamed:@"商家商场页面积分倍数-10倍积分"];
    _pointImageView.frame = CGRectMake(line.width-15-50, -25, 50, 50);
    [line addSubview:_pointImageView];
    
    UIView *businessInfoView = [UIView new];
    businessInfoView.frame = CGRectMake(0, line.y+line.height, self.view.width, 115);
    [self.view addSubview:businessInfoView];
    
    for (int index = 0; index < 4; index++) {
        UILabel *label = [UILabel new];
        label.frame = CGRectMake(10, (businessInfoView.height-20)/4*index+10, 200, (businessInfoView.height-20)/4);
        [businessInfoView addSubview:label];
        if (index == 0) {
            _businessNameLabel = label;
            label.text = @"蛋糕：金香蕉";
        } else if (index == 1) {
            _telLabel = label;
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor grayColor];
            label.text = @"电话：400-0561-009";
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button addTarget:self action:@selector(contactBusiness:) forControlEvents:UIControlEventTouchUpInside];
            UIImage *image = [UIImage imageNamed:@"拨打电话"];
            [button setBackgroundImage:image forState:UIControlStateNormal];
            CGFloat buttonHeight = label.height;
            CGFloat buttonWidth = image.size.width/image.size.height*buttonHeight;
            button.frame = CGRectMake(businessInfoView.width-10-buttonWidth, label.y, buttonWidth, buttonHeight);
            [businessInfoView addSubview:button];
            
        } else if (index == 2) {
            _addressLabel = label;
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor grayColor];
            label.text = @"地址：相山区淮海中路92-2号";
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button addTarget:self action:@selector(lookupBusinessLocation:) forControlEvents:UIControlEventTouchUpInside];
            UIImage *image = [UIImage imageNamed:@"查看商家位置"];
            CGFloat buttonWidth = 85;
            CGFloat buttonHeight = image.size.height/image.size.width*buttonWidth;
            [button setBackgroundImage:image forState:UIControlStateNormal];
            button.frame = CGRectMake(businessInfoView.width-10-buttonWidth, 0, buttonWidth, buttonHeight);
            CGPoint center = button.center;
            center.y = label.center.y;
            button.center = center;
            [businessInfoView addSubview:button];
            
        } else {
            _businessIntroLabel = label;
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor grayColor];
            label.text = @"简介：新鲜 只卖当天！！";
            
        }
        
    }
    line = [UIView new];
    line.frame = CGRectMake(0, businessInfoView.height-3.5, businessInfoView.width, 1.5);
    line.backgroundColor = kRGBColor(252, 180, 204);
    [businessInfoView addSubview:line];
    
    UIView *scoreView = [UIView new];
    scoreView.frame = CGRectMake(0, businessInfoView.y+businessInfoView.height, self.view.width, 70);
    [self.view addSubview:scoreView];
    for (int index = 0; index < 2; index++) {
        UILabel *label = [UILabel new];
        
    }
    
    self.viewFrame = CGRectMake(10, businessInfoView.y+businessInfoView.height+10, self.view.width-20, 100);
    self.view.backgroundColor = kRGBColor(237, 237, 237);

}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)lookupBusinessLocation:(UIButton *)sender {
    TEST_LOG(@"查看商家位置");
    
}
- (void)contactBusiness:(UIButton *)sender {
    TEST_LOG(@"拨打商家电话");
    NSURL *url = [NSURL URLWithString:@"tel://13051616145"];
    [[UIApplication sharedApplication] openURL:url];
}
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 3;
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    return [UIViewController new];
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return @[@"商家活动", @"商家展示", @"商家评论"][index];
}

@end
