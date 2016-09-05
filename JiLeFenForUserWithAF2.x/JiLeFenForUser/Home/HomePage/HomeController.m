//
//  HomeController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "HomeController.h"
#import "ZLImageViewDisplayView.h"
#import "HomeCell.h"
#import "SearchController.h"
#import "CategoryController.h"
#import "PartView.h"
#import "Activity.h"
@interface HomeController ()
//滑动广告视图
@property (nonatomic, strong) ZLImageViewDisplayView *imageViewDisplayView;
//积分、打折、商场、全部分类
@property (nonatomic, strong) UIView *middleView;
//热门视图
@property (nonatomic, strong) UIView *hotView;
@property (nonatomic, strong) NSArray *categoryName;
@end

@implementation HomeController
- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"首页";
        self.tabBarItem.image = [UIImage imageNamed:@"首页-点击前 透明"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"首页-点击后  透明"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化导航
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [searchButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    searchButton.frame = CGRectMake(0, 0, 100, 35);
    [searchButton setBackgroundImage:[UIImage imageNamed:@"搜索按钮"] forState:UIControlStateNormal];
    self.navigationItem.titleView = searchButton;
    //设置table view
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[HomeCell class] forCellReuseIdentifier:@"HomeCell"];
    self.tableView.backgroundColor = kRGBColor(245, 245, 245);
    
    //添加table header view
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 150+57)];
    self.tableView.tableHeaderView = tableHeaderView;
      //积分、打折、商场、全部分类
    UIView *middleView = [UIView new];
    _middleView = middleView;
    middleView.frame = CGRectMake(0, 150, tableHeaderView.bounds.size.width, 57);
    NSArray *images = @[@"首页-积分图标", @"首页-打折图标", @"首页-商超图标", @"首页-全部分类图标"];
    NSArray *titles = @[@"积分", @"打折", @"商场", @"全部分类"];
    for (int index = 0; index < images.count; index++) {
        UIView *view = [UIView new];
        view.frame = CGRectMake(middleView.width/images.count*index, 0, middleView.width/images.count, middleView.height-2);
        [middleView addSubview:view];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:images[index]];
        CGFloat buttonHeight = view.height-20;
        CGFloat buttonWidth = image.size.width/image.size.height*buttonHeight;
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.frame = CGRectMake((view.width-buttonWidth)/2, 5, buttonWidth, buttonHeight);
        [view addSubview:button];
        
        UILabel *label = [UILabel new];
        label.text = titles[index];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor grayColor];
        label.frame = CGRectMake(0, button.y+button.height, view.width, view.height-button.height-button.y);
        [view addSubview:label];
        if (index == 0) {
            [button addTarget:self action:@selector(integral) forControlEvents:UIControlEventTouchUpInside];
        } else if (index == 1) {
            [button addTarget:self action:@selector(discount) forControlEvents:UIControlEventTouchUpInside];
        } else if (index == 2) {
            [button addTarget:self action:@selector(supermarket) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [button addTarget:self action:@selector(allCategory) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    UIView *line = [UIView new];
    line.frame = CGRectMake(0, middleView.height-2, middleView.width, 2);
    line.backgroundColor = kRGBColor(241, 189, 205);
    [middleView addSubview:line];
    [tableHeaderView addSubview:middleView];

    
    //table view 下拉刷新
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
        [manager GET:@"http://www.ilovetang.com/ugohb/app.php?p=home" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"res = %@", responseObject);
            [weakSelf.tableView.mj_header endRefreshing];
            int status = [responseObject[@"status"] intValue];
            if (status == 1) {
                //轮播图，不存在则创建
                if (!_imageViewDisplayView) {
                    NSArray *flash = responseObject[@"flash"];
                    NSMutableArray *flashActivities = [NSMutableArray new];
                    for (NSDictionary *dic in flash) {
                        Activity *activity = [Activity new];
                        activity.thumb = dic[@"images"];
                        [flashActivities addObject:activity];
                    }
                    NSMutableArray *activityImages = [NSMutableArray new];
                    for (Activity *activity in flashActivities) {
                        [activityImages addObject:activity.thumb];
                    }
                    _imageViewDisplayView = [ZLImageViewDisplayView zlImageViewDisplayViewWithFrame:CGRectMake(0, 0, weakSelf.tableView.tableHeaderView.width, 150) WithImages:activityImages];
                    [weakSelf.tableView.tableHeaderView addSubview:_imageViewDisplayView];
                    
                }
                //热门板块
                if (!_hotView) {
                    NSArray *hot = responseObject[@"hot"];
                    NSInteger row = hot.count/2 + hot.count%2;
                    if (row != 0) {
                        for (NSDictionary *dic in hot) {
                            Activity *activity = [Activity new];
                            Business *business = [Business new];
                            activity.business = business;
                            activity.title = dic[@"title"];
                            activity.thumb = dic[@"thumb"];
                            business.name = dic[@"name"];
                            activity.integral = dic[@"integral"];
                        }
                        _hotView = [UIView new];
                        _hotView.layer.cornerRadius = 3;
                        _hotView.frame = CGRectMake(10, _middleView.y+_middleView.height+10, weakSelf.tableView.tableHeaderView.width-20, 150);
                        _hotView.backgroundColor = [UIColor whiteColor];
                        [weakSelf.tableView.tableHeaderView addSubview:_hotView];
                        CGRect frame = weakSelf.tableView.tableHeaderView.frame;
                        frame.size.height += 150+20;
                        weakSelf.tableView.tableHeaderView.frame = frame;
                        PartView *partView = nil;
                        CGFloat partViewHeight = _hotView.height/2;
                        CGFloat partViewWidth = _hotView.width/2;
                        for (int i = 0; i < hot.count; i++) {
                            //解析数据
                            NSDictionary *dic = hot[i];
                            Activity *activity = [Activity new];
                            Business *business = [Business new];
                            activity.business = business;
                            activity.title = dic[@"title"];
                            activity.thumb = dic[@"thumb"];
                            business.name = dic[@"name"];
                            activity.integral = dic[@"integral"];
                            //创建视图
                            partView = [[PartView alloc] init];
                            partView.frame = CGRectMake(i%2*partViewWidth, i/2*partViewHeight, partViewWidth, partViewHeight);
                            [_hotView addSubview:partView];
                            //给视图赋值显示
                            partView.activity = activity;
                            
                        }
                        //添加聚积分图标
                        UIImageView *imageView = [UIImageView new];
                        UIImage *image = [UIImage imageNamed:@"banner_toget"];
                        CGFloat width = 50;
                        CGFloat height = image.size.height/image.size.width*width;
                        imageView.frame = CGRectMake(_hotView.width-width, 0, width, height);
                        imageView.image = image;
                        [_hotView addSubview:imageView];
                    }
                    
                }
                //分类推广
                
                
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error = %@", error);
            [weakSelf.tableView.mj_header endRefreshing];
            
        }];
    }];
    [self.tableView.mj_header beginRefreshing];
   
    
}

- (NSArray *)categoryName {
    if (!_categoryName) {
        _categoryName = @[@"美食",@"服装",@"家具",@"建材"];
    }
    return _categoryName;
}



- (void)search {
    TEST_LOG(@"搜索");
    SearchController *searchController = [SearchController new];
    searchController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchController animated:YES];
    
}


- (void)integral {
    CategoryController *categoryController = [CategoryController new];
    categoryController.businessType = BusinessTypeIntegral;
    categoryController.title = @"积分";
    categoryController.sectionTitles = @[@"栏目分类", @"全部商区", @"默认排序"];
    [self.navigationController pushViewController:categoryController animated:YES];
}
- (void)discount {
    CategoryController *categoryController = [CategoryController new];
    categoryController.businessType = BusinessTypeDiscount;
    categoryController.sectionTitles = @[@"栏目分类", @"全部商区", @"默认排序"];
    categoryController.title = @"打折";
    [self.navigationController pushViewController:categoryController animated:YES];
    
}
- (void)supermarket {
    CategoryController *categoryController = [CategoryController new];
    categoryController.businessType = BusinessTypeSupermarket;
    categoryController.sectionTitles = @[@"栏目分类", @"全部商区", @"默认排序"];
    categoryController.title = @"商场";
    [self.navigationController pushViewController:categoryController animated:YES];
}
- (void)allCategory {
    CategoryController *allCategoryController = [CategoryController new];
    allCategoryController.businessType = BusinessTypeAll;
    allCategoryController.sectionTitles = @[@"建材／装潢", @"全部商区", @"店铺类别"];
    allCategoryController.title = @"建材";
    [self.navigationController pushViewController:allCategoryController animated:YES];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoryName.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    cell.moreButton.tag = indexPath.row;
    cell.categoryLabel.text = self.categoryName[indexPath.row];
    [cell.moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
- (void)moreAction:(UIButton *)sender {
    CategoryController *categoryController = [CategoryController new];
    categoryController.title = _categoryName[sender.tag];
    categoryController.businessType = BusinessTypeOther;
    [self.navigationController pushViewController:categoryController animated:YES];
    
    
}
@end
