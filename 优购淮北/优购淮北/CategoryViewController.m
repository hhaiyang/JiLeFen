//
//  CategoryViewController.m
//  优购淮北
//
//  Created by 李峰峰 on 15/8/20.
//  Copyright (c) 2015年 李峰峰. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryTableViewCell.h"
#import "CategoryMainTitles.h"
#import "CategorySubTitles.h"
#import "CategoryUrl.h"

@interface CategoryViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *firstTableView;
@property (strong, nonatomic) IBOutlet UITableView *secondTableView;

@property(strong,nonatomic)CategoryMainTitles *mainTitles;
@property(nonatomic,strong)CategorySubTitles *subTitles;
@property(nonatomic,strong)CategoryUrl *categoryurl;

@property(nonatomic,strong)NSArray *selectArray;
@property(nonatomic,strong)NSArray *selectUrl;
@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    //取消分割线
    [self.firstTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.firstTableView.rowHeight = 30;
    self.firstTableView.dataSource = self;
    self.firstTableView.delegate = self;

    //默认选择第一个选项
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.firstTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];

    
    
    self.secondTableView.rowHeight = 30;
    [self.secondTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.secondTableView.delegate = self;
    
    self.secondTableView.dataSource = self;
    
    CategoryMainTitles *mainTitles = [[CategoryMainTitles alloc]init];
    self.mainTitles = mainTitles;
    
    CategorySubTitles *subTitles = [[CategorySubTitles alloc]init];
    self.subTitles = subTitles;
    
    CategoryUrl *categoryurl = [[CategoryUrl alloc]init];
    self.categoryurl = categoryurl;


}



#pragma mark-UITableView的数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

        return 1;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    long count = 0;
    if (tableView.tag == 0) {
        count = self.mainTitles.mainTitles.count;
    }else{
        if (self.selectArray) {
            count = self.selectArray.count;
        }else{
            self.selectArray = _subTitles.subTitle[0];
            count = 4;
        }
    }
    return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc]init];
    if (tableView.tag == 0) {
        static NSString *cellIdentifier = @"CategoryTableViewCell";
        CategoryTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell1 == nil) {
            cell1 = [[[NSBundle mainBundle]loadNibNamed:@"CategoryTableViewCell" owner:self options:nil]lastObject];
        }
        
        cell1.imageName = _mainTitles.mianImages[indexPath.item];
        cell1.rightLabelText = _mainTitles.mainTitles[indexPath.item];
        cell = cell1;
    }else{

        cell.textLabel.text = _selectArray[indexPath.item];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
       
        
    }
   

    return  cell;
}

#pragma mark-UITableViewDelegate的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView.tag == 0) {
        NSArray *tempArray = _subTitles.subTitle[indexPath.item];
        self.selectArray = tempArray;
        
        NSArray *tempurl = _categoryurl.categoryUrl[indexPath.item];
        self.selectUrl = tempurl;
        NSLog(@"%@",tempurl);
        [self.secondTableView reloadData];
    }else{
    //点击的是子分类的cell
        long subselected = indexPath.item;
//        NSLog(@"点击了%@",self.selectArray[subselected]);
//        NSString *url = [[NSString alloc]init];

        
        
//        NSArray *tempurl2 = self.selectUrl[indexPath.item];
//        NSString *test = tempurl[indexPath.item];

        if (self.selectUrl[subselected] == NULL) {
            NSLog(@"113213214314");
            NSArray *tempurl = _categoryurl.categoryUrl[0];
            self.selectUrl = tempurl;
        }
        //        通知代理方法
        [self.delegate click:self.selectUrl[subselected]];


        
    }
}




@end
