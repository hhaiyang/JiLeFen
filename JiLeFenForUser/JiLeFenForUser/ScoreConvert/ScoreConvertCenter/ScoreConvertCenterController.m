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
#import "SuspendView.h"
#import "ScoreConvertHeaderView.h"
@interface ScoreConvertCenterController ()
@property (nonatomic, weak) SuspendView *suspendView;

@end

@implementation ScoreConvertCenterController
/** 控制器生命周期 */
- (instancetype)init {
    self = [super init];
    if (self) {
        [self basicSetup];
    }
    return self;
}
/** 视图生命周期 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
        
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.suspendView) {
        self.suspendView.hidden = NO;
    }
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
  
   


}
- (void)basicSetup {
    self.title = @"积分兑换中心";
    self.tabBarItem.title = @"积分兑换";
    self.tabBarItem.image = [UIImage imageNamed:@"积分兑换-点击前 透明"];
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"积分兑换-点击后 透明"];
}
- (void)initUI {
    SuspendView *view = [SuspendView suspendView];
    view.tag = 1000;
    self.suspendView = view;
    view.frame = CGRectMake(0, kScreenHeight-49-25, kScreenWidth, 25);
    [kWindow addSubview:view];
    
    ScoreConvertHeaderView *headerView = [ScoreConvertHeaderView headerView];
    [headerView.cashConvertButton addTarget:self action:@selector(cashConvert:) forControlEvents:UIControlEventTouchUpInside];
    [headerView.domesticConvertButton addTarget:self action:@selector(domesticConvert:) forControlEvents:UIControlEventTouchUpInside];
    [headerView.convertRecordButton addTarget:self action:@selector(convertRecord:) forControlEvents:UIControlEventTouchUpInside];
    headerView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 70);
    self.tableView.tableHeaderView = headerView;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScoreCell *cell = [ScoreCell scoreCellWithTableView:tableView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"全部商家";
}
- (void)cashConvert:(id)sender {
    TEST_LOG(@"现金兑换");
    CashConvertController *cashConvertController = [CashConvertController new];
    [self.navigationController pushViewController:cashConvertController animated:YES];
}
- (void)domesticConvert:(id)sender {
    TEST_LOG(@"家政服务");
    DomesticConvertController *domesticServiceController = [DomesticConvertController new];
    [self.navigationController pushViewController:domesticServiceController animated:YES];
}
- (void)convertRecord:(id)sender {
    TEST_LOG(@"兑换纪录");
    ConvertRecordController *convertRecordController = [ConvertRecordController new];
    convertRecordController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:convertRecordController animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TEST_LOG(@"进入物品兑换详情页面");
}
@end
