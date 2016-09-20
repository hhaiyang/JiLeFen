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
#import "User.h"

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
        //测试数据
        [weakSelf.tableView.mj_header endRefreshing];
        _appointmentingDomestics = @[@"", @"", @""];
        [weakSelf.tableView reloadData];
        
        //获取预约中的订单列表
        
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

//取消家政预约
- (void)abandon {
    __weak typeof(self) weakSelf = self;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
    hud.label.text = @"退订中，请稍候";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"userid"] = [User currentUser].ID;
    para[@"id"] = @"2";
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=qxjzfw" parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        TEST_LOG(@"res = %@", responseObject);
        int status = [responseObject[@"status"] intValue];
        if (status == 0) {
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"退订失败";
            [hud hideAnimated:YES afterDelay:1.5];
            return ;
        }
        [hud hideAnimated:YES];
        [_appointmentUnsubscribePopView removeFromSuperview];
        _appointmentUnsubscribePopView = nil;
        AppointmentUnsubscribeSuccessPopView *view = [AppointmentUnsubscribeSuccessPopView new];
        [view.closeButton1 addTarget:weakSelf action:@selector(closeSuccessPopView) forControlEvents:UIControlEventTouchUpInside];
        [view.closeButton2 addTarget:weakSelf action:@selector(closeSuccessPopView) forControlEvents:UIControlEventTouchUpInside];
        _appointmentUnsubscribeSuccessPopView = view;
        [kWindow addSubview:view];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        TEST_LOG(@"error = %@", error);
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"退订失败";
        [hud hideAnimated:YES afterDelay:1.5];
        
    }];
}
- (void)treasure {
    [self close];
}
- (void)closeSuccessPopView {
    [self.appointmentUnsubscribeSuccessPopView removeFromSuperview];
    self.appointmentUnsubscribeSuccessPopView = nil;
    [self.tableView.mj_header beginRefreshing];
}
@end
