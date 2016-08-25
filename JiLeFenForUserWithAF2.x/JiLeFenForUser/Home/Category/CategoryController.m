//
//  AllCategoryController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CategoryController.h"
#import "CategoryCell.h"
#import "BusinessController.h"
#import "Commbox.h"

@interface CategoryController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) NSArray *selectViews;
@property (nonatomic, strong) NSMutableArray *selectTableViews;
@end

@implementation CategoryController
- (NSMutableArray *)selectTableViews {
    if (_selectTableViews) {
        return _selectTableViews;
    }
    _selectTableViews = [NSMutableArray new];
    return _selectTableViews;
}
- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRGBColor(227, 227, 227);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回按钮" height:30];
    
    CGFloat topViewHeight = 0;
    if (_businessType != BusinessTypeOther) {
        topViewHeight = 40;
        _topView = [UIView new];
        _topView.frame = CGRectMake(0, 64, self.view.width, topViewHeight);
        _topView.backgroundColor = kRGBColor(248, 248, 248);
        [self.view addSubview:_topView];
        CGFloat space = (_topView.width-(_sectionTitles.count-1))/_sectionTitles.count;
        for (int index = 0; index < _sectionTitles.count-1; index++) {
            UIView *line = [UIView new];
            line.frame = CGRectMake(space+index*(1+space), 10, 1, _topView.height-20);
            line.backgroundColor = kRGBColor(168, 165, 164);
            [_topView addSubview:line];
        }
        
        NSMutableArray *arr = [NSMutableArray new];
        for (int index = 0; index < _sectionTitles.count; index++) {
            UIView *view = [UIView new];
            view.frame = CGRectMake(index*(space+1), 0, space, _topView.height);
            [_topView addSubview:view];
            
            Commbox *selectView = [[Commbox alloc] initWithFrame:CGRectMake(5, 0, view.width-10, view.height)];
            [selectView.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            selectView.button.tag = index;
            selectView.nameLabel.text = _sectionTitles[index];
            [view addSubview:selectView];
            [arr addObject:selectView];
            
            
            
        }
        _selectViews = [arr copy];

    }
    _contentTableView = [UITableView new];
    _contentTableView.dataSource = self;
    _contentTableView.delegate = self;
    _contentTableView.frame = self.view.bounds;
    if (_businessType != BusinessTypeOther) {
        _contentTableView.frame = CGRectMake(0,64+topViewHeight, self.view.width, self.view.height-topViewHeight-64);
    }
    _contentTableView.backgroundColor = kRGBColor(227, 227, 227);
    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_contentTableView];
    _contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_contentTableView.mj_header endRefreshing];
        
    }];
    [_contentTableView.mj_header beginRefreshing];
    
    
}
- (void)buttonAction:(UIButton *)sender {
    Commbox *selectView = (Commbox *)sender.superview;
    sender.selected = !sender.selected;
    if (sender.selected) {
        selectView.indicatorImageView.image = [UIImage imageNamed:@"UpIndicator"];
        for (UITableView *tableView in self.selectTableViews) {
            if (tableView.tag == sender.tag) {
                [self.view addSubview:tableView];
                return;
            }
          
        }
        UITableView *tableView = [UITableView new];
        tableView.tag = sender.tag;
        tableView.frame = CGRectMake(_topView.width/_sectionTitles.count*sender.tag, _topView.y+_topView.height, _topView.width/_sectionTitles.count, 150);
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        [self.selectTableViews addObject:tableView];
        return;

        
    }
    selectView.indicatorImageView.image = [UIImage imageNamed:@"DownIndicator"];
    for (UITableView *tableView in self.selectTableViews) {
        if (tableView.tag == sender.tag) {
            [tableView removeFromSuperview];
        }
        
    }
  
    
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _contentTableView) {
        return 10;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _contentTableView) {
        return 1;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [CategoryCell cellWithTableView:tableView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BusinessController *merchantController = [BusinessController new];
    [self.navigationController pushViewController:merchantController animated:YES];
}
@end
