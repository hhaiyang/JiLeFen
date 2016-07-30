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
@property (strong, nonatomic) IntroductionView *introductionView;
@property (nonatomic, strong) UILabel *cashScoreLabel;
@property (nonatomic, strong) UILabel *freeScoreLabel;
@property (nonatomic, strong) NSArray *titles;
@end

@implementation MyScoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"我的积分";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回小图标-红色" height:30];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    
    UIView *topView = [UIView new];
    topView.frame = CGRectMake(0, 64, self.view.width, 55);
    topView.backgroundColor = kRGBColor(245, 244, 245);
    [self.view addSubview:topView];
    
    _titles = @[@"增加积分", @"积分明细"];
    for (int index = 0; index < 2; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = index;
        [button setTitle:_titles[index] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(addScore:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(topView.width/2*index, 0, topView.width/2, topView.height);
        [topView addSubview:button];
    }
    
    UIView *scoreView = [UIView new];
    scoreView.layer.cornerRadius = 2;
    scoreView.frame = CGRectMake(15, topView.y+topView.height+15, self.view.width-30, 45);
    scoreView.backgroundColor = kRGBColor(232, 232, 232);
    [self.view addSubview:scoreView];
    
    UIView *line = [UIView new];
    line.frame = CGRectMake((scoreView.width-1)/2, 10, 1, scoreView.height-20);
    line.backgroundColor = kRGBColor(224, 224, 224);
    [scoreView addSubview:line];
    
    UILabel *label = nil;
    CGFloat labelWidth = scoreView.width/2;
    CGFloat labelHeight = scoreView.height;
    for (int index = 0; index < 2; index++) {
        label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(index*labelWidth, 0, labelWidth, labelHeight);
        if (index == 0) {
            _cashScoreLabel = label;
            NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"可用现金积分 " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];
            NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:@"369" attributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:17]}];
            [str1 appendAttributedString:str2];
            label.attributedText = str1;
            
        } else {
            _freeScoreLabel = label;
            NSMutableAttributedString *str = [NSMutableAttributedString new];
            NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"可用免费积分 " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];
            NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"1358" attributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:17]}];
            [str appendAttributedString:str1];
            [str appendAttributedString:str2];
            label.attributedText = str;
        }
        [scoreView addSubview:label];
    }
    
    _introductionView = [[IntroductionView alloc] initWithFrame:CGRectMake(10, scoreView.y+scoreView.height+20, self.view.width-20, self.view.height-49-20-scoreView.y-scoreView.height)];
    _introductionView.titleLabel.text = @"积分说明";
    _introductionView.detailTextView.text = @"1、在带有“可积分“标识的商家消费可领取积分；\n2、积分规则：1元＝1分（每消费人民币1元可积1分）；\n3、现金积分可兑换实物或现金（按1％兑现，即100积分可兑换1元现金，兑换现金请整兑）；兑换过的积分即清除；\n4、免费积分为您在积了分APP上所积的总积分（包含兑换过的现金／实物积分），免费积分可兑换家政服务（具体请见“积分兑换——家政”）；\n5、积了分在法律范围内保留本次活动的最终解释权。";
    [self.view addSubview:_introductionView];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addScore:(UIButton *)sender {
    
    AddScoreController *addScoreController = [[AddScoreController alloc] init];
    addScoreController.selectIndex = sender.tag;
    addScoreController.title = _titles[sender.tag];
    [self.navigationController pushViewController:addScoreController animated:YES];
}

@end
