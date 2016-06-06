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
        [weakSelf.tableView.mj_header endRefreshing];
        weakSelf.goodsArr = @[@"f", @"f"];
        [weakSelf.tableView reloadData];
        
        
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
