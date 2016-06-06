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
#import "MiddleView.h"
#import "SearchController.h"
#import "CategoryController.h"

@interface HomeController ()
@property (nonatomic, strong) NSMutableArray *tableHeaderViewImagesArray;
@property (nonatomic, strong) NSArray *categoryName;
@end

@implementation HomeController
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
    [self addTableHeaderView];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIView *view = [kWindow viewWithTag:1000];
    if (view) {
        view.hidden = YES;
    }
    
}
- (NSArray *)categoryName {
    if (!_categoryName) {
        _categoryName = @[@"美食",@"服装",@"家具",@"建材"];
    }
    return _categoryName;
}
- (void)basicSetup {
    self.title = @"首页";
    self.tabBarItem.image = [UIImage imageNamed:@"首页-点击前 透明"];
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"首页-点击后  透明"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)initUI {
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [searchButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    searchButton.frame = CGRectMake(0, 0, 100, 35);
    [searchButton setBackgroundImage:[UIImage imageNamed:@"搜索按钮"] forState:UIControlStateNormal];
    self.navigationItem.titleView = searchButton;
}
- (void)search {
    TEST_LOG(@"搜索");
    SearchController *searchController = [SearchController new];
    searchController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchController animated:YES];
    
}
- (void)addTableHeaderView {
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 155)];
    self.tableView.tableHeaderView = tableHeaderView;
    
    /** 滑动广告位 */
    self.tableHeaderViewImagesArray = [NSMutableArray arrayWithArray:@[@"标志", @"标志", @"标志", @"标志"]];
    ZLImageViewDisplayView *imageViewDisplay = [ZLImageViewDisplayView zlImageViewDisplayViewWithFrame:CGRectMake(0, 0, tableHeaderView.bounds.size.width, 100) WithImages:self.tableHeaderViewImagesArray];
    imageViewDisplay.scrollInterval = 2;
    imageViewDisplay.animationInterVale = 0.6;
    [tableHeaderView addSubview:imageViewDisplay];
    
    /** 中间四个分类 */
    MiddleView *middleView = [MiddleView middleView];
    middleView.backgroundColor = kRGBColor(236, 237, 239);
    middleView.frame = CGRectMake(0, imageViewDisplay.bounds.size.height, tableHeaderView.bounds.size.width, 55);
    [middleView.integralButton addTarget:self action:@selector(integral) forControlEvents:UIControlEventTouchUpInside];
    [middleView.discountButton addTarget:self action:@selector(discount) forControlEvents:UIControlEventTouchUpInside];
    [middleView.shangchaoButton addTarget:self action:@selector(shangchao) forControlEvents:UIControlEventTouchUpInside];
    [middleView.allCategoryButton addTarget:self action:@selector(allCategory) forControlEvents:UIControlEventTouchUpInside];
    [tableHeaderView addSubview:middleView];
    
}
- (void)integral {
    TEST_LOG(@"积分");
    CategoryController *categoryController = [CategoryController new];
    categoryController.hidesBottomBarWhenPushed = YES;
    categoryController.categoryName = @"积分";
    [self.navigationController pushViewController:categoryController animated:YES];
}
- (void)discount {
    TEST_LOG(@"打折");
    CategoryController *categoryController = [CategoryController new];
    categoryController.hidesBottomBarWhenPushed = YES;
    categoryController.categoryName = @"打折";
    [self.navigationController pushViewController:categoryController animated:YES];
    
}
- (void)shangchao {
    TEST_LOG(@"商超");
}
- (void)allCategory {
    TEST_LOG(@"全部分类");
    CategoryController *allCategoryController = [CategoryController new];
    allCategoryController.categoryName = @"所有分类";
    allCategoryController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:allCategoryController animated:YES];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoryName.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = [HomeCell cellWithTableView:tableView];
    cell.moreButton.tag = 100+indexPath.row;
    cell.categoryNameLabel.text = self.categoryName[indexPath.row];
    [cell.moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
- (void)moreAction:(UIButton *)sender {
    CategoryController *categoryController = [CategoryController new];
    categoryController.hidesBottomBarWhenPushed = YES;
    categoryController.categoryName = self.categoryName[sender.tag-100];
    [self.navigationController pushViewController:categoryController animated:YES];
    
    
}
@end
