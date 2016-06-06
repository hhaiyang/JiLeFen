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
@property (nonatomic, strong) AppointmentUnsubscribePopView *appointmentUnsubscribePopView;
@property (nonatomic, strong) AppointmentUnsubscribeSuccessPopView *appointmentUnsubscribeSuccessPopView;
@end

@implementation AppointmentingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
   
}

- (void)initUI {
    self.title = @"预约中";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回小图标-红色" height:30];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppointmentingCell *cell = [AppointmentingCell cellWithTableView:tableView];
    [cell.unsubscribeButton addTarget:self action:@selector(unsubscribe:) forControlEvents:UIControlEventTouchUpInside];
   
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
- (void)unsubscribe:(UIButton *)sender {
    TEST_LOG(@"退定");
    AppointmentUnsubscribePopView *view = [AppointmentUnsubscribePopView popView];
    [view.closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [view.abandonButton addTarget:self action:@selector(abandon) forControlEvents:UIControlEventTouchUpInside];
    [view.treasureButton addTarget:self action:@selector(treasure) forControlEvents:UIControlEventTouchUpInside];
    self.appointmentUnsubscribePopView = view;
    [kWindow addSubview:view];
}
- (void)close {
    TEST_LOG(@"关闭弹窗");
    [self.appointmentUnsubscribePopView removeFromSuperview];
    self.appointmentUnsubscribePopView = nil;
    
}
- (void)abandon {
    TEST_LOG(@"忍痛放弃");
    [self close];
    AppointmentUnsubscribeSuccessPopView *view = [AppointmentUnsubscribeSuccessPopView popView];
    for (UIButton *button in view.closeButtons) {
        [button addTarget:self action:@selector(closeSuccessPopView) forControlEvents:UIControlEventTouchUpInside];
    }
    self.appointmentUnsubscribeSuccessPopView = view;
    [kWindow addSubview:view];
    
}
- (void)treasure {
    TEST_LOG(@"继续珍惜");
    [self close];
}
- (void)closeSuccessPopView {
    [self.appointmentUnsubscribeSuccessPopView removeFromSuperview];
    self.appointmentUnsubscribeSuccessPopView = nil;
}
@end
