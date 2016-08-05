//
//  UsableScoreController.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "UsableScoreController.h"
#import "AddScoreView.h"
#import "AddScorePopView.h"
#import "QueryScoreChangeView.h"
#import "ScoreCell.h"
#define ButtonNormalColor kRGBColor(245, 245, 245)

#define ScoreCellHeight 90

@interface UsableScoreController () <AddScorePopViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIButton *scoreChangeButton;
@property (nonatomic, strong) UIButton *scoreAddRecordButton;
@property (nonatomic, strong) UILabel *usableScoreLabel;
@property (nonatomic, strong) AddScorePopView *addScorePopView;
@property (nonatomic, strong) QueryScoreChangeView *queryScoreChangeView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arr;
@end

@implementation UsableScoreController
static NSString *scoreCellID = @"ScoreCell";
- (AddScorePopView *)addScorePopView {
    if (_addScorePopView) {
        return _addScorePopView;
    }
    _addScorePopView = [AddScorePopView new];
    _addScorePopView.delegate = self;
    return _addScorePopView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"可用积分";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(toForwardVC) imageName:@"二级页面返回小图标" height:30];
    
    NSArray *titles = @[@"积分明细", @"索要记录"];
    CGFloat width = self.view.width/2;
    CGFloat height = 50;
    UIButton *button = nil;
    for (int index = 0; index < titles.count; index++) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(index*width, 64, width, height);
        [button setTitle:titles[index] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.view addSubview:button];
        if (index == 0) {
            self.scoreChangeButton = button;
            button.selected = YES;
            button.backgroundColor = [UIColor redColor];
            [button addTarget:self action:@selector(scoreChangeAction:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            self.scoreAddRecordButton = button;
            button.backgroundColor = ButtonNormalColor;
            button.selected = NO;
            [button addTarget:self action:@selector(scoreAddRecordAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    AddScoreView *view = [[AddScoreView alloc] initWithFrame:CGRectMake(10, button.y+button.height+10, self.view.width-20, 50)];
    view.usableScoreLabel.text = @"可用积分 2000";
    self.usableScoreLabel = view.usableScoreLabel;
    [view.addScoreButton addTarget:self action:@selector(addScore) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:view];
    
    QueryScoreChangeView *queryView = [[QueryScoreChangeView alloc] initWithFrame:CGRectMake(0, view.y+view.height+20, self.view.width, 25)];
    self.queryScoreChangeView = queryView;
    [self.view addSubview:queryView];
    
    UIButton *queryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    queryButton.layer.cornerRadius = 3;
    queryButton.frame = CGRectMake((self.view.width-70)/2, queryView.y+queryView.height+10, 70, 20);
    [queryButton setTitle:@"查询" forState:UIControlStateNormal];
    [queryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    queryButton.backgroundColor = [UIColor redColor];
    [queryButton addTarget:self action:@selector(queryScoreChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:queryButton];
    
    UITableView *tableView = [UITableView new];
    [tableView registerClass:[ScoreCell class] forCellReuseIdentifier:scoreCellID];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    tableView.frame = CGRectMake(0, queryButton.y+queryButton.height+15, self.view.width, self.view.height-queryButton.y-queryButton.height-15);
    [self.view addSubview:tableView];
    
    
    
}
- (void)queryScoreChange:(UIButton *)sender {
    [self.view endEditing:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    if (self.queryScoreChangeView.beginYearTextField.text.length <= 0) {
        hud.label.text = @"请输入要查询的起始年份";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    if (self.queryScoreChangeView.beginMonthTextField.text.length <= 0) {
        hud.label.text = @"请输入要查询的起始月份";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    if (self.queryScoreChangeView.endYearTextField.text.length <= 0) {
        hud.label.text = @"请输入要查询的结束年份";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    if (self.queryScoreChangeView.endMonthTextField.text.length <= 0) {
        hud.label.text = @"请输入要查询的结束月份";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"查询中，请稍候";
    if (self.scoreChangeButton.selected) {
        //查询积分明细
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"暂无数据";
            [hud hideAnimated:YES afterDelay:1.5];
        });
        return;
    }
    //查询索要记录
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"userid"] = [User currentUser].ID;
    para[@"starttime"] = [NSString stringWithFormat:@"%@-%@", self.queryScoreChangeView.beginYearTextField.text, self.queryScoreChangeView.beginMonthTextField.text];
    para[@"endtime"] = [NSString stringWithFormat:@"%@-%@", self.queryScoreChangeView.endYearTextField, self.queryScoreChangeView.endMonthTextField];
    __weak typeof(self) weakSelf = self;
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=getagentlog" parameters:para constructingBodyWithBlock:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TEST_LOG(@"res = %@", responseObject);
//        int status = [responseObject[@"status"] intValue];
//        if (status == 0) {
//            hud.mode = MBProgressHUDModeText;
//            hud.label.text = @"暂无数据";
//            [hud hideAnimated:YES afterDelay:1.5];
//            weakSelf.arr = nil;
//            [weakSelf.tableView reloadData];
//            return ;
//        }
        weakSelf.arr = @[@"d", @"fds"];
        [hud hideAnimated:YES];
        [weakSelf.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        TEST_LOG(@"error = %@", error);
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"查询失败";
        [hud hideAnimated:YES afterDelay:1.5];
    }];
    
}
- (void)toForwardVC {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)scoreChangeAction:(UIButton *)sender {
    [self.view endEditing:YES];
    sender.selected = YES;
    sender.backgroundColor = [UIColor redColor];
    self.scoreAddRecordButton.selected = NO;
    self.scoreAddRecordButton.backgroundColor = ButtonNormalColor;
    
}
- (void)scoreAddRecordAction:(UIButton *)sender {
    [self.view endEditing:YES];
    sender.selected = YES;
    sender.backgroundColor = [UIColor redColor];
    self.scoreChangeButton.selected = NO;
    self.scoreChangeButton.backgroundColor = ButtonNormalColor;
}
- (void)addScore {
    [self.view endEditing:YES];
    [kWindow addSubview:self.addScorePopView];
    
    
}
- (void)addScorePopView:(AddScorePopView *)view didClickedCloseButton:(UIButton *)button {
    [view removeFromSuperview];
}
- (void)addScorePopView:(AddScorePopView *)view didClickedBackButton:(UIButton *)button {
    [view removeFromSuperview];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:scoreCellID];
    cell.firstLabel.text = @"2015年10月05日10:05";
    cell.secondLabel.text = @"+10000";
    cell.thirdLabel.text = @"可用20200";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ScoreCellHeight;
}
@end
