//
//  MyAttentionController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyAttentionListController.h"
#import "MyAttentionCell.h"
#import "MyAttentionPopView.h"
#import "User.h"

@interface MyAttentionListController ()
@property (nonatomic, strong) MyAttentionPopView *cancelAttentionPopView;
@property (nonatomic, strong) NSArray *myAttentions;
@end

@implementation MyAttentionListController
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
        //获取我的关注列表
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
        NSMutableDictionary *para = [NSMutableDictionary new];
        para[@"userid"] = [User currentUser].ID;
        [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=getconcern" parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
            [weakSelf.tableView.mj_header endRefreshing];
            TEST_LOG(@"res = %@", responseObject);
            int status = [responseObject[@"status"] intValue];
            if (status == 0) {
                _myAttentions = nil;
            } else if (status == 1) {
                //缺少返回json示例，无法解析
            }
            [weakSelf.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [weakSelf.tableView.mj_header endRefreshing];
            TEST_LOG(@"error = %@", error);
            
        }];
        
//        //测试数据
//        _myAttentions = @[@"", @"", @""];
//        [weakSelf.tableView.mj_header endRefreshing];
//        [weakSelf.tableView reloadData];
        
        
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
//确定取消关注
- (void)confirmCancelAttention {
    __weak typeof(self) weakSelf = self;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
    hud.label.text = @"取消中，请稍后";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"id"] = [User currentUser].ID;
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=cannelconcern" parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
       
        int status = [responseObject[@"status"] intValue];
        if (status == 0) {
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"取消失败";
            [hud hideAnimated:YES afterDelay:1.5];
        } else if (status == 1) {
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"取消成功";
            [hud hideAnimated:YES afterDelay:1.5];
            [_cancelAttentionPopView removeFromSuperview];
            _cancelAttentionPopView = nil;
            [weakSelf.tableView.mj_header beginRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"取消失败";
        [hud hideAnimated:YES afterDelay:1.5];
        
    }];
}
- (void)doNotCancelAttention {
    [self closeCancelAttentionPopView];
}
@end
