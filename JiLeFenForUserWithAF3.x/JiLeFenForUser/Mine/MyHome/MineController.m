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
@interface MineController ()
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
    label.text = @"你还没有登录哦～";
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(30, (imageView.height-21)/2, imageView.width-60, 21);
    [imageView addSubview:label];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *loginImage = [UIImage imageNamed:@"我的主界面-登陆按钮"];
    CGFloat loginButtonHeight = 45;
    CGFloat loginButtonWidth = loginImage.size.width/loginImage.size.height*loginButtonHeight;
    loginButton.frame = CGRectMake((imageView.width-loginButtonWidth)/2, label.y+label.height+8, loginButtonWidth, loginButtonHeight);
    [loginButton setBackgroundImage:loginImage forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:loginButton];
    
    UIView *actionView = [UIView new];
    actionView.frame = CGRectMake(0, imageView.y+imageView.height, tableheaderView.width, tableheaderView.height-imageView.height);
    actionView.backgroundColor = kRGBColor(245, 244, 245);
    [tableheaderView addSubview:actionView];
    
    UIView *subview = nil;
    CGFloat subviewWidth = actionView.width/3;
    CGFloat subviewHeight = actionView.height;
    NSArray *titles = @[@"我的积分", @"我的关注", @"我的关联号"];
    NSArray *images = @[@"我的积分", @"我的关注", @"我的关联号"];
    for (int index = 0; index < 3; index++) {
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
        } else {
            [button addTarget:self action:@selector(myRelatedAccount:) forControlEvents:UIControlEventTouchUpInside];
        }
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
    self.navigationController.navigationBar.hidden = YES;
    UIView *view = [kWindow viewWithTag:1000];
    if (view) {
        view.hidden = YES;
    }
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
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
    MyScoreController *myScoreController = [MyScoreController new];
   
    [self.navigationController pushViewController:myScoreController animated:YES];
}
- (void)myAttention:(id)sender {
    TEST_LOG(@"我的关注");
    MyAttentionController *myAttentionController = [[MyAttentionController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:myAttentionController animated:YES];
}
- (void)myRelatedAccount:(id)sender {
    TEST_LOG(@"我的关联号");
    MyRelatedAccountController *myRelatedAccountController = [MyRelatedAccountController new];
    myRelatedAccountController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myRelatedAccountController animated:YES];
}
@end
