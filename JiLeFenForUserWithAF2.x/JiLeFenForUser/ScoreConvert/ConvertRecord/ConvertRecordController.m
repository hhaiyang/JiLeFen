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
#import "UnsubscribeConfirmPopView.h"
#import "UnsubscribeSuccessView.h"
#import "User.h"

@interface ConvertRecordController () <UnsubscribeConfirmPopViewDelegate, UnsubscribeSuccessViewDelegate>
@property (nonatomic, strong) NSArray *goodsConvertRecordArr;
@property (nonatomic, strong) LookConvertCodePopView *lookConvertCodePopView;
@property (nonatomic, strong) UnsubscribeConfirmPopView *unsubscribeConfirmPopView;
@property (nonatomic, strong) UnsubscribeSuccessView *unsubscribeSuccessView;
@end

@implementation ConvertRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物品兑换记录";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回小图标-红色" height:30];
    self.tableView.backgroundColor = kRGBColor(249, 249, 249);
    
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //获取物品兑换记录
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
        NSMutableDictionary *para = [NSMutableDictionary new];
        para[@"userid"] = [User currentUser].ID;
        para[@"isget"] = @"-1";
        [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=cashlist" parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
            [weakSelf.tableView.mj_header endRefreshing];
            NSLog(@"res = %@", responseObject);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error = %@", error);
            
        }];
        
    }];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _goodsConvertRecordArr.count;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)lookConvertCode:(UIButton *)sender {
    TEST_LOG(@"查看兑换码");
    LookConvertCodePopView *view = [[LookConvertCodePopView alloc] init];
    [view.cornerCloseButton addTarget:self action:@selector(closeLookConvertCodePopView) forControlEvents:UIControlEventTouchUpInside];
    [view.bottomCloseButton addTarget:self action:@selector(closeLookConvertCodePopView) forControlEvents:UIControlEventTouchUpInside];
    self.lookConvertCodePopView = view;
    [kWindow addSubview:view];
}
- (void)unsubscribe:(UIButton *)sender {
    TEST_LOG(@"退订");
    _unsubscribeConfirmPopView = [[UnsubscribeConfirmPopView alloc] init];
    _unsubscribeConfirmPopView.delegate = self;
    [kWindow addSubview:_unsubscribeConfirmPopView];

}
- (void)closeLookConvertCodePopView {
    [self.lookConvertCodePopView removeFromSuperview];
    self.lookConvertCodePopView = nil;
}
- (void)unsubscribeConfirmPopView:(UnsubscribeConfirmPopView *)view didClickCloseButton:(UIButton *)button {
    [view removeFromSuperview];
    
}
- (void)unsubscribeConfirmPopView:(UnsubscribeConfirmPopView *)view didClickGiveupButton:(UIButton *)button {
    [view removeFromSuperview];
    _unsubscribeSuccessView = [[UnsubscribeSuccessView alloc] init];
    _unsubscribeSuccessView.delegate = self;
    [kWindow addSubview:_unsubscribeSuccessView];
    
}
- (void)unsubscribeConfirmPopView:(UnsubscribeConfirmPopView *)view didClickCherishButton:(UIButton *)button {
    [view removeFromSuperview];
    
}
- (void)unsubscribeSuccessView:(UnsubscribeSuccessView *)view didClickedCornerCloseButton:(UIButton *)button {
    [view removeFromSuperview];
}

- (void)unsubscribeSuccessView:(UnsubscribeSuccessView *)view didClickedBottomCloseButton:(UIButton *)button {
    [view removeFromSuperview];
    
}
@end
