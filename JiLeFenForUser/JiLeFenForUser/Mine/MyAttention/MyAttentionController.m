//
//  MyAttentionController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyAttentionController.h"
#import "MyAttentionCell.h"
#import "CancelAttentionPopView.h"

@interface MyAttentionController ()
@property (nonatomic, strong) CancelAttentionPopView *cancelAttentionPopView;
@end

@implementation MyAttentionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicSetup];
    
}
- (void)basicSetup {
    self.title = @"我的关注";
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(backAction:) imageName:@"返回小图标-红色" height:30];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
}
- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyAttentionCell *cell = [MyAttentionCell myAttentionCellWithTableView:tableView];
    [cell.cancelAttentionButton addTarget:self action:@selector(cancelAttentionAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
- (void)cancelAttentionAction:(id)sender {
    TEST_LOG(@"取消关注");
    CancelAttentionPopView *cancelAttentionPopView = [CancelAttentionPopView cancelAttentionPopView];
    [cancelAttentionPopView.closeButton addTarget:self action:@selector(closeCancelAttentionPopView) forControlEvents:UIControlEventTouchUpInside];
    [cancelAttentionPopView.confirmButton addTarget:self action:@selector(confirmCancelAttention) forControlEvents:UIControlEventTouchUpInside];
    [cancelAttentionPopView.cancelButton addTarget:self action:@selector(doNotCancelAttention) forControlEvents:UIControlEventTouchUpInside];
    self.cancelAttentionPopView = cancelAttentionPopView;
    [kWindow addSubview:cancelAttentionPopView];
}
- (void)closeCancelAttentionPopView {
    [self.cancelAttentionPopView removeFromSuperview];
    self.cancelAttentionPopView = nil;
}
- (void)confirmCancelAttention {
    [self closeCancelAttentionPopView];
}
- (void)doNotCancelAttention {
    [self closeCancelAttentionPopView];
}
@end
