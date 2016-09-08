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
#import "ScoreListController.h"
#import "User.h"


@interface MyScoreController ()
@property (strong, nonatomic) IntroductionView *introductionView;
@property (nonatomic, strong) UILabel *cashScoreLabel;
@property (nonatomic, strong) UILabel *freeScoreLabel;

@end

@implementation MyScoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化导航
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"我的积分";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回小图标-红色" height:30];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    

    UIBarButtonItem *addScore = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(addScore:) imageName:@"AddScore" height:25];
    UIBarButtonItem *scoreList = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(scoreList) imageName:@"ScoreList" height:25];
    self.navigationItem.rightBarButtonItems = @[addScore, scoreList];
    
    //获取数据，根据数据刷新界面，如果获取失败，则显示点击重新刷新
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"userid"] = [User currentUser].ID;
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=userinfo" parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"res = %@", responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@", error);
        
    }];
    UIView *scoreView = [UIView new];
    scoreView.layer.cornerRadius = 2;
    scoreView.frame = CGRectMake(15, 64+20, self.view.width-30, 45);
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
//增加积分
- (void)addScore:(UIButton *)sender {
    
    AddScoreController *addScoreController = [[AddScoreController alloc] init];
    [self.navigationController pushViewController:addScoreController animated:YES];
}
//积分明细
- (void)scoreList {
    ScoreListController *scoreList = [ScoreListController new];
    [self.navigationController pushViewController:scoreList animated:YES];
    
}
@end
