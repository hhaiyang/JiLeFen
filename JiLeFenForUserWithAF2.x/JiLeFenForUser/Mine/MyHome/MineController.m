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
#import "User.h"
@interface MineController ()
@property (nonatomic, strong) UILabel *userStatusLabel;
@property (nonatomic, strong) UIButton *userStatusButton;
@end

@implementation MineController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"我的";
        self.tabBarItem.image = [UIImage imageNamed:@"我的-点击前 透明"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"我的-点击后 透明"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
     [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"otherCell"];
    UIView *tableheaderView = [UIView new];
    tableheaderView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 220);
    self.tableView.tableHeaderView = tableheaderView;
    
    UIImageView *imageView = [UIImageView new];
    imageView.userInteractionEnabled = YES;
    imageView.frame = CGRectMake(0, 0, tableheaderView.width, 160);
    imageView.backgroundColor = kRGBColor(201, 252, 208);
    [tableheaderView addSubview:imageView];
    
    UILabel *label = [UILabel new];
    _userStatusLabel = label;
    label.text = @"你还没有登录哦～";
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(30, (imageView.height-21)/2, imageView.width-60, 21);
    [imageView addSubview:label];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _userStatusButton = loginButton;
    [_userStatusButton setBackgroundColor:kRGBColor(226, 85, 109)];
    loginButton.layer.cornerRadius = 5;
    CGFloat loginButtonHeight = 30;
    CGFloat loginButtonWidth = 70;
    loginButton.frame = CGRectMake((imageView.width-loginButtonWidth)/2, label.y+label.height+15, loginButtonWidth, loginButtonHeight);
    [imageView addSubview:loginButton];
    
    UIView *actionView = [UIView new];
    actionView.frame = CGRectMake(0, imageView.y+imageView.height, tableheaderView.width, tableheaderView.height-imageView.height);
    actionView.backgroundColor = kRGBColor(245, 244, 245);
    [tableheaderView addSubview:actionView];
    
    //我的积分，我的关注
    UIView *subview = nil;
    NSArray *titles = @[@"我的积分", @"我的关注"/*, @"我的关联号"*/];
    NSArray *images = @[@"我的积分", @"我的关注"/*, @"我的关联号"*/];
    CGFloat subviewWidth = actionView.width/titles.count;
    CGFloat subviewHeight = actionView.height;
    for (int index = 0; index < titles.count; index++) {
        subview = [UIView new];
        subview.backgroundColor = [UIColor clearColor];
        subview.frame = CGRectMake(index*subviewWidth, 0, subviewWidth, subviewHeight);
        [actionView addSubview:subview];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:images[index]];
        CGFloat buttonHeight = subview.height-23;
        CGFloat buttonWidth = image.size.width/image.size.height*buttonHeight;
        button.frame = CGRectMake((subview.width-buttonWidth)/2, 3, buttonWidth, buttonHeight);
        [button setBackgroundImage:image forState:UIControlStateNormal];
        if (index == 0) {
            [button addTarget:self action:@selector(myScore:) forControlEvents:UIControlEventTouchUpInside];
        } else if (index == 1) {
            [button addTarget:self action:@selector(myAttention:) forControlEvents:UIControlEventTouchUpInside];
        } /*else {
            [button addTarget:self action:@selector(myRelatedAccount:) forControlEvents:UIControlEventTouchUpInside];
        }*/
        [subview addSubview:button];
        
        UILabel *label = [UILabel new];
        label.text = titles[index];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:13];
        label.frame = CGRectMake(3, button.y+button.height, subview.width-6, subview.height-button.y-button.height-3);
        [subview addSubview:label];
    }
    
       
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
    [self updateUI];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([User currentUser].status == NoLogin) {
        return 0;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherCell"];
    cell.textLabel.text = @"修改密码";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"其他";
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        ModifyPasswordController *modifyPsaawordController = [ModifyPasswordController new];
        [self.navigationController pushViewController:modifyPsaawordController animated:YES];
}

- (void)login:(id)sender {
    TEST_LOG(@"登录");
    LoginController *loginController = [LoginController new];
    UINavigationController *loginNavi = [[UINavigationController alloc] initWithRootViewController:loginController];
    [self presentViewController:loginNavi animated:YES completion:nil];
}
- (void)myScore:(id)sender {
    TEST_LOG(@"我的积分");
//    if ([User currentUser].status == NoLogin) {
//        [self login:nil];
//        return;
//    }
    MyScoreController *myScoreController = [MyScoreController new];
   
    [self.navigationController pushViewController:myScoreController animated:YES];
}
- (void)myAttention:(id)sender {
    TEST_LOG(@"我的关注");
//    if ([User currentUser].status == NoLogin) {
//        [self login:nil];
//        return;
//    }
    MyAttentionController *myAttentionController = [[MyAttentionController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:myAttentionController animated:YES];
}
/*
- (void)myRelatedAccount:(id)sender {
    TEST_LOG(@"我的关联号");
    if ([User currentUser].status == NoLogin) {
        [self login:nil];
        return;
    }
    MyRelatedAccountController *myRelatedAccountController = [MyRelatedAccountController new];
    myRelatedAccountController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myRelatedAccountController animated:YES];
}
 */
//退出登录
- (void)logout {
    TEST_LOG(@"退出");
    User *user = [User currentUser];
    user.ID = nil;
    user.status = NoLogin;
    [self updateUI];

    
}
- (void)updateUI {
    //判断用户状态
    if ([User currentUser].status == NoLogin) {
        [_userStatusButton setTitle:@"登陆" forState:UIControlStateNormal];
        [_userStatusButton removeTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        [_userStatusButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        _userStatusLabel.text = @"你还没有登录哦～";
    } else {
        [_userStatusButton setTitle:@"注销" forState:UIControlStateNormal];
        [_userStatusButton removeTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        [_userStatusButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        _userStatusLabel.text = [User currentUser].ID;
    }
    [self.tableView reloadData];
}
@end
