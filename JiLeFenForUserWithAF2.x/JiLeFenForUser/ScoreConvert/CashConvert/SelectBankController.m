//
//  SelectBankController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/6/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "SelectBankController.h"
#import "Bank.h"
@interface SelectBankController ()
@property (nonatomic, strong) NSArray *banks;
@end

@implementation SelectBankController
- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择银行";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(backAction) imageName:@"返回小图标-红色" height:30];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"BankCell"];
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
        [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=banklist" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [weakSelf.tableView.mj_header endRefreshing];
            TEST_LOG(@"res = %@", responseObject);
            int status = [responseObject[@"status"] intValue];
            if (status == 1) {
                NSArray *arr = responseObject[@"data"];
                NSMutableArray *banks = [NSMutableArray new];
                for (NSDictionary *dic in arr) {
                    Bank *bank = [Bank new];
                    bank.ID = dic[@"bankid"];
                    bank.name = dic[@"bankname"];
                    [banks addObject:bank];
                    
                }
                _banks = [banks copy];
                [weakSelf.tableView reloadData];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            TEST_LOG(@"erro = %@", error);
            [weakSelf.tableView.mj_header endRefreshing];
            
        }];
        
    }];
    [self.tableView.mj_header beginRefreshing];
    
       
    
   
}
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _banks.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BankCell" forIndexPath:indexPath];
    Bank *bank = _banks[indexPath.row];
    cell.textLabel.text = bank.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Bank *bank = _banks[indexPath.row];
    self.cashConvertController.bankLabel.text = bank.name;
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
