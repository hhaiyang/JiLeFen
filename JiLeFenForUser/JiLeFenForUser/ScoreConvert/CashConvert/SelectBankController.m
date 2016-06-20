//
//  SelectBankController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/6/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "SelectBankController.h"
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
    __weak typeof(self) weakSSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
        [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=banklist" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [weakSSelf.tableView.mj_header endRefreshing];
            TEST_LOG(@"res = %@", responseObject);
            [weakSSelf.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            TEST_LOG(@"erro = %@", error);
            [weakSSelf.tableView.mj_header endRefreshing];
            _banks = @[@"中国银行", @"中国农业银行", @"中国建设银行", @"中国交通银行"];
            [weakSSelf.tableView reloadData];
            
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
    
    cell.textLabel.text = _banks[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.cashConvertController.backLabel.text = _banks[indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
