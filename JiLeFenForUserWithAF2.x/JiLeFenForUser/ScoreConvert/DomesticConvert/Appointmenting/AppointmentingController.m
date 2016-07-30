//
//  AppointmentController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/3.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AppointmentingController.h"
#import "AppointmentingCell.h"
#import "AppointmentUnsubscribePopView.h"
#import "AppointmentUnsubscribeSuccessPopView.h"

@interface AppointmentingController ()
@property (nonatomic, strong) NSArray *appointmentingDomestics;
@property (nonatomic, strong) AppointmentUnsubscribePopView *appointmentUnsubscribePopView;
@property (nonatomic, strong) AppointmentUnsubscribeSuccessPopView *appointmentUnsubscribeSuccessPopView;
@end

@implementation AppointmentingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = kRGBColor(250, 250, 250);
    self.title = @"预约中";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回小图标-红色" height:30];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf.tableView.mj_header endRefreshing];
        _appointmentingDomestics = @[@"", @"", @""];
        [weakSelf.tableView reloadData];
    }];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView registerClass:[AppointmentingCell class] forCellReuseIdentifier:@"AppointmentingCell"];
    
    
    
}
- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _appointmentingDomestics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppointmentingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppointmentingCell"];
    [cell.unsubscribeButton addTarget:self action:@selector(unsubscribe:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
- (void)unsubscribe:(UIButton *)sender {
    AppointmentUnsubscribePopView *view = [AppointmentUnsubscribePopView new];
    [view.closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [view.abandonButton addTarget:self action:@selector(abandon) forControlEvents:UIControlEventTouchUpInside];
    [view.treasureButton addTarget:self action:@selector(treasure) forControlEvents:UIControlEventTouchUpInside];
    self.appointmentUnsubscribePopView = view;
    [kWindow addSubview:view];
}
- (void)close {
    [self.appointmentUnsubscribePopView removeFromSuperview];
    self.appointmentUnsubscribePopView = nil;
    
}
- (void)abandon {
    __weak typeof(self) weakSelf = self;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
    hud.label.text = @"退订中，请稍候";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
        [weakSelf close];
        AppointmentUnsubscribeSuccessPopView *view = [AppointmentUnsubscribeSuccessPopView new];
        [view.closeButton1 addTarget:weakSelf action:@selector(closeSuccessPopView) forControlEvents:UIControlEventTouchUpInside];
        [view.closeButton2 addTarget:weakSelf action:@selector(closeSuccessPopView) forControlEvents:UIControlEventTouchUpInside];
        
        _appointmentUnsubscribeSuccessPopView = view;
        [kWindow addSubview:view];

        
    });
    
}
- (void)treasure {
    [self close];
}
- (void)closeSuccessPopView {
    [self.appointmentUnsubscribeSuccessPopView removeFromSuperview];
    self.appointmentUnsubscribeSuccessPopView = nil;
}
@end
