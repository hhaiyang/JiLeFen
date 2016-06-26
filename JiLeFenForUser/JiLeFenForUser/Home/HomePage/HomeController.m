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

@interface HomeController ()
@property (nonatomic, strong) NSMutableArray *tableHeaderViewImagesArray;
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initUI];
    [self addTableHeaderView];
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView registerClass:[HomeCell class] forCellReuseIdentifier:@"HomeCell"];
    self.tableView.backgroundColor = kRGBColor(245, 245, 245);
    
}

- (NSArray *)categoryName {
    if (!_categoryName) {
        _categoryName = @[@"美食",@"服装",@"家具",@"建材"];
    }
    return _categoryName;
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
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 157)];
    self.tableView.tableHeaderView = tableHeaderView;
    
    /** 滑动广告位 */
    self.tableHeaderViewImagesArray = [NSMutableArray arrayWithArray:@[@"标志", @"标志", @"标志", @"标志"]];
    ZLImageViewDisplayView *imageViewDisplay = [ZLImageViewDisplayView zlImageViewDisplayViewWithFrame:CGRectMake(0, 0, tableHeaderView.bounds.size.width, 100) WithImages:self.tableHeaderViewImagesArray];
    imageViewDisplay.scrollInterval = 2;
    imageViewDisplay.animationInterVale = 0.6;
    [tableHeaderView addSubview:imageViewDisplay];
    
    /** 中间四个分类 */
    UIView *middleView = [UIView new];
    middleView.frame = CGRectMake(0, imageViewDisplay.bounds.size.height, tableHeaderView.bounds.size.width, 57);
    NSArray *images = @[@"首页-积分图标", @"首页-打折图标", @"首页-商超图标", @"首页-全部分类图标"];
    NSArray *titles = @[@"积分", @"打折", @"商超", @"全部分类"];
    for (int index = 0; index < 4; index++) {
        UIView *view = [UIView new];
        view.frame = CGRectMake(middleView.width/4*index, 0, middleView.width/4, middleView.height-2);
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
            [button addTarget:self action:@selector(shangchao) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [button addTarget:self action:@selector(allCategory) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    UIView *line = [UIView new];
    line.frame = CGRectMake(0, middleView.height-2, middleView.width, 2);
    line.backgroundColor = kRGBColor(241, 189, 205);
    [middleView addSubview:line];
    
    [tableHeaderView addSubview:middleView];
    
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
- (void)shangchao {
}
- (void)allCategory {
    CategoryController *allCategoryController = [CategoryController new];
    allCategoryController.businessType = BusinessTypeAll;
    allCategoryController.sectionTitles = @[@"建材／装潢", @"全部商区", @"店铺类别"];
    allCategoryController.title = @"建材";
    [self.navigationController pushViewController:allCategoryController animated:YES];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
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
