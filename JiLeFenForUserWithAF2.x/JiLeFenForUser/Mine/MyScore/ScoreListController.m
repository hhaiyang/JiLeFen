//
//  ScoreRecordController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/6/19.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ScoreListController.h"
#import "Commbox.h"
#import "SelectDateView.h"

@interface ScoreListController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
//显示分类的table view
@property (nonatomic, strong) UITableView *categoryTableView;
//显示积分明细的table view
@property (nonatomic, strong) UITableView *scoreListTableView;
//查询类别的下拉菜单
@property (nonatomic, strong) Commbox *commbox;
@property (nonatomic, strong) NSArray *categoryTitles;
//选择日期视图
@property (nonatomic, strong) SelectDateView *selectDateView;
@property (nonatomic, strong) UITextField *beginYearTextField;
@property (nonatomic, strong) UITextField *beginMonthTextField;
@property (nonatomic, strong) UITextField *endYearTextField;
@property (nonatomic, strong) UITextField *endMonthTextField;
@end

@implementation ScoreListController
- (NSArray *)categoryTitles {
    if (_categoryTitles) {
        return _categoryTitles;
    }
    _categoryTitles = @[@"现金积分", @"免费积分"];
    return _categoryTitles;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"积分明细";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(back) imageName:@"返回小图标-红色" height:30];
    
    //显示“查询类别”的标签
    UILabel *label = [UILabel new];
    label.text = @"查询类别: ";
    label.font = [UIFont systemFontOfSize:13];
    label.frame = CGRectMake(20, 64+20, 65, 21);
    [self.view addSubview:label];
    
    //选择类别视图
    Commbox *selectView = [[Commbox alloc] initWithFrame:CGRectMake(label.x+label.width, label.y, 100, label.height)];
    _commbox = selectView;
    selectView.layer.cornerRadius = 1;
    selectView.layer.borderWidth = 1;
    selectView.layer.borderColor = [kRGBColor(218, 218, 218) CGColor];
    selectView.nameLabel.text = @"请选择类别";
    selectView.nameLabel.font = [UIFont systemFontOfSize:11];
    [selectView.button addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectView];
    
    //选择日期视图
    _selectDateView = [[SelectDateView alloc] initWithFrame:CGRectMake(0, _commbox.y+_commbox.height+10, self.view.width, 21)];
    _selectDateView.beginYearTextField.delegate = self;
    _selectDateView.beginMonthTextField.delegate = self;
    _selectDateView.endYearTextField.delegate = self;
    _selectDateView.endMonthTextField.delegate = self;
    [self.view addSubview:_selectDateView];
    
    //查询按钮
    UIButton *queryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    queryButton.layer.cornerRadius = 3;
    queryButton.frame = CGRectMake((self.view.width-70)/2, _selectDateView.y+_selectDateView.height+10, 70, 20);
    [queryButton setTitle:@"查询" forState:UIControlStateNormal];
    [queryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    queryButton.backgroundColor = [UIColor redColor];
    [queryButton addTarget:self action:@selector(queryScoreList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:queryButton];
    
    //积分明细的table view
    UITableView *tableView = [UITableView new];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _scoreListTableView = tableView;
    tableView.frame = CGRectMake(0, queryButton.y+queryButton.height+15, self.view.width, self.view.height-queryButton.y-queryButton.height-15-49);
    [self.view addSubview:tableView];

}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)selectCategory:(UIButton *)sender {
    Commbox *selectView = (Commbox *)sender.superview;
    sender.selected = !sender.selected;
    if (sender.selected) {
        selectView.indicatorImageView.image = [UIImage imageNamed:@"UpIndicator"];
        UITableView *tableView = [UITableView new];
        _categoryTableView = tableView;
        tableView.frame = CGRectMake(selectView.x, selectView.y+selectView.height, selectView.width, 50);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.layer.borderWidth = 1;
        tableView.layer.borderColor = selectView.layer.borderColor;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CategoryTableViewCell"];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        return;
        
    }
    selectView.indicatorImageView.image = [UIImage imageNamed:@"DownIndicator"];
    [_categoryTableView removeFromSuperview];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //查询类别的table view
    if (tableView == _categoryTableView) {
        return 2;
    }
    //显示积分明细的table view
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //查询类别的table view
    if (tableView == _categoryTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryTableViewCell"];

        cell.textLabel.text = self.categoryTitles[indexPath.row];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:11];
        return cell;
    }
    //积分明细的table view
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _categoryTableView) {
         return tableView.height/2;
    }
   
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == _categoryTableView) {
        _commbox.nameLabel.text = self.categoryTitles[indexPath.row];
        [self selectCategory:_commbox.button];
        return;
    }
    
}
//查询
- (void)queryScoreList {
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == _selectDateView.beginYearTextField) {
        
    } else if (textField == _selectDateView.beginMonthTextField) {
        if (_selectDateView.beginYearTextField.text.length <= 0) {
            
        } else {
            
        }
        
    } else if (textField == _selectDateView.endYearTextField) {
        
    } else {
        
    }
    return NO;
}

@end
