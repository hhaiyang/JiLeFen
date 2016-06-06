//
//  MineController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MineController.h"
#import "ModifyPasswordController.h"
#import "LoginController.h"
#import "MyScoreController.h"
#import "MyAttentionController.h"
#import "MyRelatedAccountController.h"
#import "MineHeaderView.h"
@interface MineController ()
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *imageArr;
@end

@implementation MineController
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
    self.navigationController.navigationBar.hidden = YES;
    UIView *view = [kWindow viewWithTag:1000];
    if (view) {
        view.hidden = YES;
    }
}
- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"联系客服", @"修改密码"];
    }
    return _titleArr;
}
- (NSArray *)imageArr {
    if (!_imageArr) {
        _imageArr = @[@"输入账号-小人物", @"输入密码-锁"];
    }
    return _imageArr;
}
- (void)basicSetup {
    self.title = @"我的";
    self.tabBarItem.image = [UIImage imageNamed:@"我的-点击前 透明"];
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"我的-点击后 透明"];
    
}
- (void)initUI {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 220)];
    MineHeaderView *headerView = [MineHeaderView headerView];
    headerView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 220);
    [headerView.loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [headerView.myScoreButton addTarget:self action:@selector(myScore:) forControlEvents:UIControlEventTouchUpInside];
    [headerView.myAttentionButton addTarget:self action:@selector(myAttention:) forControlEvents:UIControlEventTouchUpInside];
    [headerView.myRelatedAccountButton addTarget:self action:@selector(myRelatedAccount:) forControlEvents:UIControlEventTouchUpInside];
    headerView.frame = view.bounds;
    [view addSubview:headerView];
    self.tableView.tableHeaderView = view;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"otherCell"];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherCell"];
    cell.textLabel.text = self.titleArr[indexPath.row];
    //cell.imageView.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"其他";
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
    } else if (indexPath.row == 1) {
        ModifyPasswordController *modifyPsaawordController = [ModifyPasswordController new];
        [self.navigationController pushViewController:modifyPsaawordController animated:YES];
    }
}

- (void)login:(id)sender {
    TEST_LOG(@"登录");
    LoginController *loginController = [LoginController new];
    loginController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginController animated:YES];
}
- (void)myScore:(id)sender {
    TEST_LOG(@"我的积分");
    MyScoreController *myScoreController = [MyScoreController new];
   
    [self.navigationController pushViewController:myScoreController animated:YES];
}
- (void)myAttention:(id)sender {
    TEST_LOG(@"我的关注");
    MyAttentionController *myAttentionController = [MyAttentionController new];
    myAttentionController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myAttentionController animated:YES];
}
- (void)myRelatedAccount:(id)sender {
    TEST_LOG(@"我的关联号");
    MyRelatedAccountController *myRelatedAccountController = [MyRelatedAccountController new];
    myRelatedAccountController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myRelatedAccountController animated:YES];
}
@end
