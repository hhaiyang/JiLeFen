//
//  DomesticServiceController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "DomesticConvertController.h"
#import "AppointmentingController.h"
#import "IntroductionView.h"
#import "AppointmentedController.h"
#import "AppointmentCell.h"
@interface DomesticConvertController ()
@property (nonatomic, strong) UILabel *freeScoreLabel;
@property (nonatomic, strong) UILabel *appointmentingLabel;
@property (nonatomic, strong) UILabel *appointmentedLabel;
@end

@implementation DomesticConvertController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"免费兑换中心";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(backAction) imageName:@"返回小图标-红色" height:30];
    
    UIView *tableHeaderView = [UIView new];
    tableHeaderView.frame = CGRectMake(0, 0, self.tableView.width, 65);
    self.tableView.tableHeaderView = tableHeaderView;
    
    UIView *freeScoreView = [UIView new];
    freeScoreView.backgroundColor = kRGBColor(232, 232, 232);
    freeScoreView.frame = CGRectMake(10, 10, tableHeaderView.width-20, tableHeaderView.height-20);
    [tableHeaderView addSubview:freeScoreView];
    
    CGFloat space = (freeScoreView.width-2)/3;
    for (int index = 0; index < 2; index++) {
        UIView *line = [UIView new];
        line.backgroundColor = kRGBColor(214, 214, 214);
        line.frame = CGRectMake(space+index*(space+1), 10, 1, freeScoreView.height-20);
        [freeScoreView addSubview:line];
    }
    
    for (int index = 0; index < 3; index++) {
        UILabel *label = [UILabel new];
        label.userInteractionEnabled = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(freeScoreView.width/3*index, 0, freeScoreView.width/3, freeScoreView.height);
        [freeScoreView addSubview:label];
        if (index == 0) {
            _freeScoreLabel = label;
            NSMutableAttributedString *str = [NSMutableAttributedString new];
            NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"免费积分 " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9]}];
            NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"5899" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20], NSForegroundColorAttributeName:[UIColor redColor]}];
            [str appendAttributedString:str1];
            [str appendAttributedString:str2];
            _freeScoreLabel.attributedText = str;
        } else if (index == 1) {
            _appointmentingLabel = label;
            NSMutableAttributedString *str = [NSMutableAttributedString new];
            NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"预约中  " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9]}];
            NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"1" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20], NSForegroundColorAttributeName:kRGBColor(0, 174, 156)}];
            [str appendAttributedString:str1];
            [str appendAttributedString:str2];
            _appointmentingLabel.attributedText = str;
            
            UITapGestureRecognizer *appointmentingGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toAppointmentingVC:)];
            [label addGestureRecognizer:appointmentingGR];
            
        } else {
            _appointmentedLabel = label;
            NSMutableAttributedString *str = [NSMutableAttributedString new];
            NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"已预约  " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9]}];
            NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"2" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20], NSForegroundColorAttributeName:[UIColor redColor]}];
            [str appendAttributedString:str1];
            [str appendAttributedString:str2];
            _appointmentedLabel.attributedText = str;
            
            UITapGestureRecognizer *appointmentedGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toAppointmentedVC:)];
            [label addGestureRecognizer:appointmentedGR];

        }
    }
    
    IntroductionView *introView = [[IntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 200)];
    introView.titleLabel.text = @"  温馨提示：";
    introView.titleLabel.textColor = [UIColor redColor];
    introView.detailTextView.text = @"1、免费积分和现金积分分为单独的两个系统；\n2、免费积分中兑换的服务是积了分额外赠送给会员使用的，削减免费积分2000分。例如：您在积了分APP上积分5000分，您可以在现金兑换窗口兑换现金50元，剩余积分为0分，额外在本免费积分窗口兑换家政服务2次，剩余免费积分1000分；如果您未兑换家政，又积分2000分，您的剩余积分为2000分，在现金兑换专区可兑换20元，免费积分共有7000分，可兑换家政服务3次，只要在本免费积分系统您未参与兑换，免费积分不会和兑换现金、物品一起削减掉。";
    self.tableView.tableFooterView = introView;
    
    [self.tableView registerClass:[AppointmentCell class] forCellReuseIdentifier:@"AppointmentCell"];
    
    
}
- (void)toAppointmentingVC:(id)sender {
    AppointmentingController *appointmentController = [AppointmentingController new];
    [self.navigationController pushViewController:appointmentController animated:YES];
}
- (void)toAppointmentedVC:(UITapGestureRecognizer *)sender {
    AppointmentedController *appointmented = [AppointmentedController new];
    [self.navigationController pushViewController:appointmented animated:YES];
    
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppointmentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppointmentCell"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}
@end
