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
#import "DomesticConvertCell.h"
@interface DomesticConvertController ()

@end

@implementation DomesticConvertController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}
- (void)appointmenting:(id)sender {
    TEST_LOG(@"预约中");
    AppointmentingController *appointmentController = [AppointmentingController new];
    [self.navigationController pushViewController:appointmentController animated:YES];
}

- (void)initUI {
    self.title = @"免费兑换中心";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(backAction) imageName:@"返回小图标-红色" height:30];
    
    
    
    IntroductionView *view = [[IntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 150)];
    //view.backgroundColor = [UIColor lightGrayColor];
    view.titleLabel.text = @"  温馨提示：";
    view.detailTextView.text = @"1、免费积分和现金积分分为单独的两个系统；\n2、免费积分中兑换的服务是积了分额外赠送给会员使用的，削减免费积分2000分。例如：您在积了分APP上积分5000分，您可以在现金兑换窗口兑换现金50元，剩余积分为0分，额外在本免费积分窗口兑换家政服务2次，剩余免费积分1000分；如果您未兑换家政，又积分2000分，您的剩余积分为2000分，在现金兑换专区可兑换20元，免费积分共有7000分，可兑换家政服务3次，只要在本免费积分系统您未参与兑换，免费积分不会和兑换现金、物品一起削减掉。";
    self.tableView.tableFooterView = view;
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
    UITableViewCell *cell = nil;
    cell = [DomesticConvertCell cellWithTableView:tableView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
@end
