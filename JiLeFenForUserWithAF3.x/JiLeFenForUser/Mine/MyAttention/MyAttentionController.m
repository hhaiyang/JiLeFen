//
//  MyAttentionController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyAttentionController.h"
#import "MyAttentionCell.h"
#import "MyAttentionPopView.h"

@interface MyAttentionController ()
@property (nonatomic, strong) MyAttentionPopView *cancelAttentionPopView;
@property (nonatomic, strong) NSArray *myAttentions;
@end

@implementation MyAttentionController
- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的关注";
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(backAction:) imageName:@"返回小图标-红色" height:30];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.myAttentions = @[@"", @"", @""];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView reloadData];
        
    }];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView registerClass:[MyAttentionCell class] forCellReuseIdentifier:@"MyAttentionCell"];
}
- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myAttentions.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyAttentionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyAttentionCell"];
    [cell.cancelAttentionButton addTarget:self action:@selector(cancelAttentionAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
- (void)cancelAttentionAction:(id)sender {
    TEST_LOG(@"取消关注");
    MyAttentionPopView *cancelAttentionPopView = [MyAttentionPopView new];
    [cancelAttentionPopView.closeButton addTarget:self action:@selector(closeCancelAttentionPopView) forControlEvents:UIControlEventTouchUpInside];
    [cancelAttentionPopView.sureButton addTarget:self action:@selector(confirmCancelAttention) forControlEvents:UIControlEventTouchUpInside];
    [cancelAttentionPopView.cancelButton addTarget:self action:@selector(doNotCancelAttention) forControlEvents:UIControlEventTouchUpInside];
    self.cancelAttentionPopView = cancelAttentionPopView;
    [kWindow addSubview:cancelAttentionPopView];
}
- (void)closeCancelAttentionPopView {
    [self.cancelAttentionPopView removeFromSuperview];
    self.cancelAttentionPopView = nil;
}
- (void)confirmCancelAttention {
    [self closeCancelAttentionPopView];
}
- (void)doNotCancelAttention {
    [self closeCancelAttentionPopView];
}
@end
