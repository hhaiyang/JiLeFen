//
//  AccountController.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AccountController.h"
#import "AccountInfoView.h"
#import "LoginController.h"
#import "ModifyPasswordController.h"

@interface AccountController ()

@end

@implementation AccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"账号管理";
    self.tableView.backgroundColor = DEFAULT_VIEW_CONTROLLER_BACKGROUND_COLOR;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(toForwardVC) imageName:@"二级页面返回小图标" height:30];
    AccountInfoView *infoView = [[AccountInfoView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 44*3)];
    self.tableView.tableHeaderView = infoView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    UIImage *image = [UIImage imageNamed:@"退出账号"];
    CGFloat width = self.tableView.width-40;
    CGFloat height = image.size.height/image.size.width*width;
    [logoutButton setBackgroundImage:image forState:UIControlStateNormal];
    logoutButton.frame = CGRectMake(20, self.tableView.height-height-100, width, height);
    [self.tableView addSubview:logoutButton];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.tableView addGestureRecognizer:tap];
    
}
- (void)toForwardVC {
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ModifyPasswordCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ModifyPasswordCell"];
        UITapGestureRecognizer *tapRow = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toModifyPasswordVC)];
        [cell addGestureRecognizer:tapRow];
    }
    cell.textLabel.text = @"登录密码";
    cell.detailTextLabel.text = @"修改";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}


- (void)toModifyPasswordVC {
    TEST_LOG(@"修改密码");
    [self hideKeyboard];
    ModifyPasswordController *modifyPassword = [ModifyPasswordController new];
    [self.navigationController pushViewController:modifyPassword animated:YES];
    
}
- (void)logout {
    TEST_LOG(@"退出登录");
    [self hideKeyboard];
    kWindow.rootViewController = [[UINavigationController alloc] initWithRootViewController:[LoginController new]];
    
}
- (void)hideKeyboard {
    [self.view endEditing:YES];
}
- (void)tapAction {
    [self hideKeyboard];
}
@end
