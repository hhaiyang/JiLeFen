//
//  AppointmentedController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/6/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AppointmentedController.h"
#import "AppointmentedCell.h"

@interface AppointmentedController ()
@property (nonatomic, strong) NSArray *appointmentedDomestics;
@end

@implementation AppointmentedController
- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"已预约";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(backAction) imageName:@"返回小图标-红色" height:30];
    __weak typeof(self) weakSelf = self;
     self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         [weakSelf.tableView.mj_header endRefreshing];
         _appointmentedDomestics = @[@"", @"", @""];
         [weakSelf.tableView reloadData];
        
    }];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView registerClass:[AppointmentedCell class] forCellReuseIdentifier:@"AppointmentedCell"];
    self.tableView.backgroundColor = kRGBColor(250, 250, 250);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _appointmentedDomestics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppointmentedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppointmentedCell" forIndexPath:indexPath];
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
@end
