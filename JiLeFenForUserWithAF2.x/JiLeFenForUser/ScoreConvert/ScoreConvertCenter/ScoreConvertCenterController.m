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
#import "Goods.h"
#import "User.h"
#import "LoginController.h"

@interface ScoreConvertCenterController ()
@property (nonatomic, strong) NSArray *goodsList;

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
    [self.tableView registerClass:[ScoreCell class] forCellReuseIdentifier:@"ScoreCell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getGoodsListForConvert)];
    [self.tableView.mj_header beginRefreshing];
    
    
    
    
}
//获取用于积分兑换的商品列表，商家商品分两类，一类是用现金买，一类用于积分兑换
- (void)getGoodsListForConvert {
    __weak typeof(self) weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager GET:@"http://www.ilovetang.com/ugohb/app.php?p=integral" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        TEST_LOG(@"res = %@", responseObject);
        [weakSelf.tableView.mj_header endRefreshing];
        int status = [responseObject[@"status"] intValue];
        if (status == 1) {
            NSArray *arr = responseObject[@"shops"];
            NSMutableArray *goodsList = [NSMutableArray new];
            for (NSDictionary *dic in arr) {
                Goods *goods = [Goods new];
                [goods setValuesForKeysWithDictionary:dic];
                [goodsList addObject:goods];
                
            }
            _goodsList = [goodsList copy];
            [weakSelf.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        TEST_LOG(@"error = %@", error);
        [weakSelf.tableView.mj_header endRefreshing];
        
    }];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _goodsList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScoreCell"];
    Goods *goods = _goodsList[indexPath.row];
    cell.goods = goods;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"物品兑换区";
}

//跳转到现金兑换界面
- (void)cashConvert:(id)sender {
    //首先判断用户是否登录，如果已经登录直接跳转，否则让用户先登录
    if ([User currentUser].status == Login) {
        CashConvertController *cashConvertController = [CashConvertController new];
        [self.navigationController pushViewController:cashConvertController animated:YES];
    } else {
        [self toLoginController];
    }
    
    
}
//跳转到家政兑换界面
- (void)domesticConvert:(id)sender {
    //首先判断用户是否已经登录，如果是则直接跳转，否则让用户先登录
    if ([User currentUser].status == Login) {
        DomesticConvertController *domesticServiceController = [DomesticConvertController new];
        [self.navigationController pushViewController:domesticServiceController animated:YES];
    } else {
        [self toLoginController];
    }
  
}
//跳转到兑换记录界面
- (void)convertRecord:(id)sender {
    //首先判断用户是否已经登录，如果是则直接跳转，否则让用户先登录
    if ([User currentUser].status == Login) {
        ConvertRecordController *convertRecordController = [ConvertRecordController new];
        convertRecordController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:convertRecordController animated:YES];
    } else {
        [self toLoginController];
    }
    
}
//跳转到登录界面
- (void)toLoginController {
    LoginController *login = [LoginController new];
    UINavigationController *loginNavi = [[UINavigationController alloc] initWithRootViewController:login];
    [self presentViewController:loginNavi animated:YES completion:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GoodsConvertController *goodsConvert = [GoodsConvertController new];
    [self.navigationController pushViewController:goodsConvert animated:YES];
}
@end
