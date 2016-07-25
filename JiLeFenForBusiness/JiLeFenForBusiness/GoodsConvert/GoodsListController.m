//
//  GoodsListController.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "GoodsListController.h"
#import "GoodsInfoCell.h"

#define GoodsInfoCellHeight 90

@interface GoodsListController ()
@property (nonatomic, strong) NSArray *goodsArr;
@end

@implementation GoodsListController
static NSString *goodsInfoCellID = @"GoodsInfoCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
        NSMutableDictionary *para = [NSMutableDictionary new];
        para[@"userid"] = [User currentUser].ID;
        para[@"isget"] = @"-1";
        [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=cashlist" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [weakSelf.tableView.mj_header endRefreshing];
            TEST_LOG(@"res = %@", responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            TEST_LOG(@"error = %@", error);
            [weakSelf.tableView.mj_header endRefreshing];
        }];
        
        
    }];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView registerClass:[GoodsInfoCell class] forCellReuseIdentifier:goodsInfoCellID];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goodsArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsInfoCellID forIndexPath:indexPath];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return GoodsInfoCellHeight;
}


@end
