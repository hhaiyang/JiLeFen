//
//  AllCategoryController.m
//  JiLeFenForUser
//
//  Created by hhy on 16/9/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AllCategoryController.h"
#import "Cate.h"
#import "BusinessListController.h"

@interface AllCategoryController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign, getter=isFirstCateLoadSuccess) BOOL firstCateLoadSuccess;
@property (nonatomic, assign, getter=isSecondCateLoadSuccess) BOOL secondCateLoadSuccess;
@property (nonatomic, strong) NSArray *firstCateArray;
@property (nonatomic, strong) NSArray *secondCateArray;
@property (nonatomic, strong) UITableView *firstCateTableView;
@property (nonatomic, strong) UITableView *secondCateTableView;
@end

@implementation AllCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回按钮" height:30];
    self.title = @"全部";
    self.automaticallyAdjustsScrollViewInsets = NO;
    //创建两个table view分别用于显示一级、二级分类
    _firstCateTableView = [UITableView new];
    _firstCateTableView.frame = CGRectMake(0, 64, self.view.width/5*3, self.view.height-64);
    [_firstCateTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"FirstCateTableViewCell"];
    _firstCateTableView.dataSource = self;
    _firstCateTableView.delegate = self;
    [self.view addSubview:_firstCateTableView];
    _secondCateTableView = [UITableView new];
    _secondCateTableView.frame = CGRectMake(_firstCateTableView.width, 64, self.view.width-_firstCateTableView.width, self.view.height-64);
    _secondCateTableView.dataSource = self;
    _secondCateTableView.delegate = self;
    [_secondCateTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SecondCateTableViewCell"];
    [self.view addSubview:_secondCateTableView];
    //加载一级分类
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"拼了命为您加载中";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager POST:@"http://www.ugohb.com/app/app.php?j=user&type=firstcategory" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        _firstCateLoadSuccess = YES;
        NSArray *arr = (NSArray *)responseObject;
        NSMutableArray *cates = [NSMutableArray new];
        for (NSDictionary *dic in arr) {
            Cate *cate = [Cate new];
            cate.ID = dic[@"catid"];
            cate.name = dic[@"catname"];
            [cates addObject:cate];
            
        }
        _firstCateArray = [cates copy];
        [_firstCateTableView reloadData];
        
        //加载默认的二级分类
        NSMutableDictionary *para = [NSMutableDictionary new];
        Cate *cate = (Cate *)[_firstCateArray firstObject];
        para[@"parentid"] = cate.ID;
        [manager POST:@"http://www.ugohb.com/app/app.php?j=user&type=childcategory" parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
            [hud hideAnimated:YES];
            NSArray *arr = (NSArray *)responseObject;
            NSMutableArray *cates = [NSMutableArray new];
            for (NSDictionary *dic in arr) {
                Cate *cate = [Cate new];
                cate.ID = dic[@"catid"];
                cate.name = dic[@"catname"];
                [cates addObject:cate];
            }
            _secondCateArray = [cates copy];
            [_secondCateTableView reloadData];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [hud hideAnimated:YES];
            
        }];
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //加载失败以后再说
        [hud hideAnimated:YES];
        
        
    }];

}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _firstCateTableView) {
        return _firstCateArray.count;
    }
    return _secondCateArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _firstCateTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstCateTableViewCell"];
        Cate *cate = _firstCateArray[indexPath.row];
        cell.textLabel.text = cate.name;
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondCateTableViewCell"];
    Cate *cate = _secondCateArray[indexPath.row];
    cell.textLabel.text = cate.name;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //点击一级分类加载二级分类数据
    if (tableView == _firstCateTableView) {
        Cate *cate = _firstCateArray[indexPath.row];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
        hud.label.text = @"拼了老命为您加载中";
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
        NSMutableDictionary *para = [NSMutableDictionary new];
        para[@"parentid"] = cate.ID;
        [manager POST:@"http://www.ugohb.com/app/app.php?j=user&type=childcategory" parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {

            [hud hideAnimated:YES];
            NSArray *arr = (NSArray *)responseObject;
            NSMutableArray *cates = [NSMutableArray new];
            for (NSDictionary *dic in arr) {
                Cate *cate = [Cate new];
                cate.ID = dic[@"catid"];
                cate.name = dic[@"catname"];
                [cates addObject:cate];
            }
            _secondCateArray = [cates copy];
            [_secondCateTableView reloadData];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"加载失败";
            [hud hideAnimated:YES afterDelay:1.5];
            
            
        }];
        return;
    }
    
   //点击二级分类跳转到商家列表界面
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Cate *cate = _secondCateArray[indexPath.row];
    BusinessListController *businessList = [BusinessListController new];
    businessList.cate = cate;
    [self.navigationController pushViewController:businessList animated:YES];

    
    
}


@end
