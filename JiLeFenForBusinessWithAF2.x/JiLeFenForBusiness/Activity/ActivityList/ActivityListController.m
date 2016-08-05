//
//  ActivityListController.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ActivityListController.h"
#import "CreateActivityController.h"
#import "ActivityCell.h"
#import "Activity.h"

#define ActivityCellHeight 72
#define ActivityCellID @"ActivityCell"

@interface ActivityListController ()
@property (nonatomic, strong) NSArray *activities;
@end

@implementation ActivityListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动列表";
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(toForwardVC) imageName:@"二级页面返回小图标" height:30];
    
    UIBarButtonItem *createActivityItem = [[UIBarButtonItem alloc] initWithTitle:@"发活动" style:UIBarButtonItemStylePlain target:self action:@selector(toCreateActivityVC)];
    self.navigationItem.rightBarButtonItem = createActivityItem;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = DEFAULT_VIEW_CONTROLLER_BACKGROUND_COLOR;
    [self.tableView registerClass:[ActivityCell class] forCellReuseIdentifier:ActivityCellID];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestActivityList)];
    [self.tableView.mj_header beginRefreshing];
    
    
    
}
- (void)toForwardVC {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)requestActivityList {
    __weak typeof(self) weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=activelist" parameters:nil constructingBodyWithBlock:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TEST_LOG(@"res = %@", responseObject);
        [weakSelf.tableView.mj_header endRefreshing];
        int status = [responseObject[@"status"] intValue];
        if (status == 1) {
            NSArray *data = responseObject[@"data"];
            NSMutableArray *activities = [NSMutableArray new];
            for (NSDictionary *dic in data) {
                Activity *activity = [Activity new];
                activity.hit = dic[@"hit"];
                activity.title = dic[@"title"];
                activity.img_path = dic[@"img_path"];
                [activities addObject:activity];
                
            }
            weakSelf.activities = [activities copy];
            [weakSelf.tableView reloadData];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
    
}
- (void)toCreateActivityVC {
    CreateActivityController *createActivity = [CreateActivityController new];
    createActivity.activityListController = self;
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:createActivity];
    [self presentViewController:navi animated:YES completion:nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.activities.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ActivityCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:ActivityCellID];
    cell.activity = self.activities[indexPath.row];
    return cell;
}

@end
