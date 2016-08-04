//
//  GoodsConvertUnavailableController.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/7/24.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "GoodsConvertUnavailableController.h"

@interface GoodsConvertUnavailableController ()

@end

@implementation GoodsConvertUnavailableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DEFAULT_VIEW_CONTROLLER_BACKGROUND_COLOR;
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(toForwardVC) imageName:@"二级页面返回小图标" height:30];
    self.title = @"物品兑换";
    
    NSArray *titles = @[@"对不起，您暂时还未开通兑换功能！", @"如需开通，请联系客服！"];
    UILabel *label = nil;
    CGFloat labelWidth = self.view.width-20;
    CGFloat labelHeight = 21;
    for (int index = 0; index < titles.count; index++) {
        label = [UILabel new];
        label.text = titles[index];
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(10, index*(labelHeight+10)+130, labelWidth, labelHeight);
        [self.view addSubview:label];
    }
    
    UIImageView *imageView = [UIImageView new];
    UIImage *image = [UIImage imageNamed:@"物品兑换-客服电话"];
    CGFloat imageViewHeight = 50;
    CGFloat imageViewWidth = image.size.width/image.size.height*imageViewHeight;
    imageView.image = image;
    imageView.frame = CGRectMake((self.view.width-imageViewWidth)/2, label.y+label.height+10, imageViewWidth, imageViewHeight);
    [self.view addSubview:imageView];

    
}

- (void)toForwardVC {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
