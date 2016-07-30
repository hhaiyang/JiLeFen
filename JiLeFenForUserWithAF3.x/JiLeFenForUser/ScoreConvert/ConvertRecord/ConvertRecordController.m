//
//  ConvertRecordController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ConvertRecordController.h"
#import "NotGetCell.h"
#import "AlreadyGetCell.h"
#import "LookConvertCodePopView.h"

@interface ConvertRecordController ()
@property (nonatomic, strong) LookConvertCodePopView *lookConvertCodePopView;
@end

@implementation ConvertRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}
- (void)initUI {
    self.title = @"物品兑换记录";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回小图标-红色" height:30];
    self.tableView.backgroundColor = kRGBColor(249, 249, 249);
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.section == 0 || indexPath.section == 5) {
        cell = [NotGetCell cellWithTableView:tableView];
        NotGetCell *notGetCell = (NotGetCell *)cell;
        notGetCell.lookConvertCodeButton.tag = indexPath.section;
        [notGetCell.lookConvertCodeButton addTarget:self action:@selector(lookConvertCode:) forControlEvents:UIControlEventTouchUpInside];
        notGetCell.unsubscribeButton.tag = indexPath.section;
        [notGetCell.unsubscribeButton addTarget:self action:@selector(unsubscribe:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        cell = [AlreadyGetCell cellWithTableView:tableView];
    }
    
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15;
}
- (void)lookConvertCode:(UIButton *)sender {
    TEST_LOG(@"查看兑换码");
    TEST_LOG(@"button tag = %d", sender.tag);
    LookConvertCodePopView *view = [LookConvertCodePopView popView];
    [view.cornerCloseButton addTarget:self action:@selector(closeLookConvertCodePopView) forControlEvents:UIControlEventTouchUpInside];
    [view.bottomCloseButton addTarget:self action:@selector(closeLookConvertCodePopView) forControlEvents:UIControlEventTouchUpInside];
    self.lookConvertCodePopView = view;
    [kWindow addSubview:view];
}
- (void)unsubscribe:(UIButton *)sender {
    TEST_LOG(@"退订");
    TEST_LOG(@"button tag = %d", sender.tag);
}
- (void)closeLookConvertCodePopView {
    [self.lookConvertCodePopView removeFromSuperview];
    self.lookConvertCodePopView = nil;
}
@end
