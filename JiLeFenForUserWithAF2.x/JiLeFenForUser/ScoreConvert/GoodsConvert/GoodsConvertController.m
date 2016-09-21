//
//  GoodConvertDetailController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/4.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "GoodsConvertController.h"

@interface GoodsConvertController ()
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UIButton *refreshButton;
@end

@implementation GoodsConvertController
- (UIButton *)refreshButton {
    if (_refreshButton) {
        return _refreshButton;
    }
    _refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _refreshButton.frame = CGRectMake(0, 0, 150, 30);
    CGPoint center = _refreshButton.center;
    center.x = self.view.width/2;
    center.y = self.view.height/2;
    _refreshButton.center = center;
    [_refreshButton setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [_refreshButton setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateHighlighted];
    [_refreshButton setTitle:@"重新刷新" forState:UIControlStateNormal];
    [_refreshButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_refreshButton addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    return _refreshButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物品兑换";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(backAction) imageName:@"返回小图标-红色" height:30];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
   
    //请求数据
    [self getGoodsInfo];
    
   
    
    
    
}
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)refresh:(UIButton *)button {
    [button removeFromSuperview];
    [self getGoodsInfo];
}
//获取兑换物品信息
- (void)getGoodsInfo {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"id"] = @"01";
    __weak typeof(self) weakSelf = self;
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=goodsinfo" parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        TEST_LOG(@"res = %@", responseObject);
        [hud hideAnimated:YES];
        int status = [responseObject[@"status"] intValue];
        if (status == 0) {
            [weakSelf.view addSubview:weakSelf.refreshButton];
            return ;
        }
        //在这处理数据获取成功事件
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [hud hideAnimated:YES];
        [weakSelf.view addSubview:weakSelf.refreshButton];
        
        
    }];

    
}
@end
