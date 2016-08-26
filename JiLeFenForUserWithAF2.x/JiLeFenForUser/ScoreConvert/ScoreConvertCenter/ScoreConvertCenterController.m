//
//  ScoreController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ScoreConvertCenterController.h"
#import "ScoreCell.h"
#import "CashConvertController.h"
#import "DomesticConvertController.h"
#import "ConvertRecordController.h"
#import "GoodsConvertController.h"

@interface ScoreConvertCenterController ()
@property (nonatomic, strong) NSArray *allShop;

@end

@implementation ScoreConvertCenterController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"积分兑换中心";
        self.tabBarItem.title = @"积分兑换";
        self.tabBarItem.image = [UIImage imageNamed:@"积分兑换-点击前 透明"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"积分兑换-点击后 透明"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    UIView *headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 70);
    self.tableView.tableHeaderView = headerView;
    UIView *actionView = nil;
    CGFloat actionViewWidth = headerView.width/3;
    CGFloat actionViewHeight = headerView.height;
    NSArray *images = @[@"积分兑换中心-现金兑换", @"积分兑换中心-家政服务", @"积分兑换中心-兑换记录"];
    NSArray *titles = @[@"现金兑换区", @"家政服务区", @"物品兑换记录"];
    for (int index = 0; index < 3; index++) {
        actionView = [UIView new];
        actionView.frame = CGRectMake(index*actionViewWidth, 0, actionViewWidth, actionViewHeight);
        [headerView addSubview:actionView];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:images[index]];
        CGFloat buttonHeight = actionView.height-30;
        CGFloat buttonWidth = image.size.width/image.size.height*buttonHeight;
        button.frame = CGRectMake((actionView.width-buttonWidth)/2, 10, buttonWidth, buttonHeight);
        [button setBackgroundImage:image forState:UIControlStateNormal];
        if (index == 0) {
            [button addTarget:self action:@selector(cashConvert:) forControlEvents:UIControlEventTouchUpInside];
        } else if (index == 1) {
            [button addTarget:self action:@selector(domesticConvert:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [button addTarget:self action:@selector(convertRecord:) forControlEvents:UIControlEventTouchUpInside];
        }
        [actionView addSubview:button];
        
        UILabel *label = [UILabel new];
        label.text = titles[index];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        label.frame = CGRectMake(3, button.y+button.height+3, actionView.width-6, actionView.height-10-6-button.height);
        [actionView addSubview:label];
        
    }
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _allShop = @[@"", @"", @"", @"", @""];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView reloadData];
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
//        NSMutableDictionary *para = [NSMutableDictionary new];
//        para[@"pagesize"] = @"10";
//        para[@"pagenum"] = @"1";
//        [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=goodslist" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            [weakSelf.tableView.mj_header endRefreshing];
//            TEST_LOG(@"res = %@", responseObject);
//            
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            TEST_LOG(@"error = %@", error);
//            [weakSelf.tableView.mj_header endRefreshing];
//            
//        }];
        
    }];
    [self.tableView.mj_header beginRefreshing];
    

        
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
       
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _allShop.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScoreCell *cell = [ScoreCell scoreCellWithTableView:tableView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"物品兑换区";
}

//跳转到现金兑换界面
- (void)cashConvert:(id)sender {
    CashConvertController *cashConvertController = [CashConvertController new];
    [self.navigationController pushViewController:cashConvertController animated:YES];
}
- (void)domesticConvert:(id)sender {
    DomesticConvertController *domesticServiceController = [DomesticConvertController new];
    [self.navigationController pushViewController:domesticServiceController animated:YES];
}
- (void)convertRecord:(id)sender {
    ConvertRecordController *convertRecordController = [ConvertRecordController new];
    convertRecordController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:convertRecordController animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GoodsConvertController *goodsConvert = [GoodsConvertController new];
    [self.navigationController pushViewController:goodsConvert animated:YES];
}
@end
