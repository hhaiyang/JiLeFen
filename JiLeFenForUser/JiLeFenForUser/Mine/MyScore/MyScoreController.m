//
//  MyScoreController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyScoreController.h"
#import "AddScoreController.h"
#import "IntroductionView.h"


@interface MyScoreController ()
@property (weak, nonatomic) IBOutlet IntroductionView *introductionView;

@end

@implementation MyScoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}
- (void)initUI {
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"我的积分";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回小图标-红色" height:30];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    
    self.introductionView.titleLabel.text = @"积分说明";
    self.introductionView.detailTextView.text = @"1、在带有“可积分“标识的商家消费可领取积分；\n2、积分规则：1元＝1分（每消费人民币1元可积1分）；\n3、现金积分可兑换实物或现金（按1％兑现，即100积分可兑换1元现金，兑换现金请整兑）；兑换过的积分即清除；\n4、免费积分为您在积了分APP上所积的总积分（包含兑换过的现金／实物积分），免费积分可兑换家政服务（具体请见“积分兑换——家政”）；\n5、积了分在法律范围内保留本次活动的最终解释权。";
    
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addScore:(id)sender {
    
    AddScoreController *addScoreController = [AddScoreController new];
    [self.navigationController pushViewController:addScoreController animated:YES];
}

@end
