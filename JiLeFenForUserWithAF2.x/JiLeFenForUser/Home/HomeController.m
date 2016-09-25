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
#import "BusinessListController.h"
#import "PartView.h"
#import "Activity.h"
#import "RocationCollectionViewCell.h"
#import "AllCategoryController.h"
#import "BusinessController.h"
#import "BusinessWebController.h"
@interface HomeController () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UIWebViewDelegate>
@property (nonatomic, strong) UIScrollView *parentScrollView;
@property (strong, nonatomic)UICollectionView  *rocationCollectionView;
@property(strong,nonatomic)UIPageControl *rocationPageControl;
@property(strong,nonatomic)UIWebView *mainWebView;
@property (nonatomic, strong) UIView *categoryView;

@property(strong,nonatomic)NSMutableArray *imageArray;
@property(strong,nonatomic)NSMutableArray *clickArray;

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
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithObjects:@"http://www.ugohb.com/attachment/flash/1439454273cdfub.jpg", nil];
    self.imageArray = tempArray;

    self.title = @"首页";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    [self addScrollView];
    [self getJSON];
    [self addCollectionView];
    [self addPageControl];
    [self addTimer];
    [self addCategoryIcon];
   
}
-(void)viewDidAppear:(BOOL)animated{
    CGFloat testheight = self.mainWebView.frame.size.height;
    if (testheight <200) {
        [self addWebView];
        NSLog(@"[self addWebView]");
    }
    
}

//跳转到搜索界面
- (void)toSearchController {
    TEST_LOG(@"搜索");
    SearchController *searchController = [SearchController new];
    searchController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchController animated:YES];
    
}


//添加搜索功能
- (void)addSearch {
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [searchButton addTarget:self action:@selector(toSearchController) forControlEvents:UIControlEventTouchUpInside];
    searchButton.frame = CGRectMake(0, 0, 100, 35);
    [searchButton setBackgroundImage:[UIImage imageNamed:@"搜索按钮"] forState:UIControlStateNormal];
    self.navigationItem.titleView = searchButton;
}
//添加滚动视图
- (void)addScrollView {
    _parentScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_parentScrollView];
}
//从服务器中获得轮播广告图片
-(void)getJSON{
    
    
    dispatch_queue_t q = dispatch_queue_create("com.ttdazhe.ugohb", DISPATCH_QUEUE_SERIAL);
    dispatch_async(q, ^{
        
        //获取图片路径
        //在子线程中获取json字符串并解析
        NSURL *adsUrl = [NSURL URLWithString:@"http://www.ugohb.com/client/adimages/download.html"];
        NSString *jsonstr = [NSString stringWithContentsOfURL:adsUrl encoding:NSUTF8StringEncoding error:nil];
        //把json字符串转为Data
        NSData *jsonData = [jsonstr dataUsingEncoding:NSUTF8StringEncoding];
        
        if (jsonData != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:NULL];
            
            NSMutableArray *tempArray = [[NSMutableArray alloc]init];
            for (int i = 0; i < [dic[@"number"]intValue]; i++) {
                NSString *imageName = [[NSString alloc]init];
                imageName = [NSString stringWithFormat:@"image%d",i];
                [tempArray addObject:dic[imageName]];
                
            }
            self.imageArray = tempArray;
            
            //            NSLog(@"%@",self.imageArray);
            [self.rocationCollectionView reloadData];
        }
        
        //获取点击跳转链接
        //在子线程中获取json字符串并解析
        NSURL *clickUrl = [NSURL URLWithString:@"http://www.ugohb.com/client/adimages/clickurl.html"];
        NSString *clickjsonstr = [NSString stringWithContentsOfURL:clickUrl encoding:NSUTF8StringEncoding error:nil];
        //把json字符串转为Data
        NSData *clickjsonData = [clickjsonstr dataUsingEncoding:NSUTF8StringEncoding];
        
        if (jsonData != nil) {
            NSDictionary *clickdic = [NSJSONSerialization JSONObjectWithData:clickjsonData options:0 error:NULL];
            
            NSMutableArray *tempArray2 = [[NSMutableArray alloc]init];
            for (int i = 0; i < self.imageArray.count; i++) {
                NSString *imageName = [[NSString alloc]init];
                imageName = [NSString stringWithFormat:@"image%d",i];
                [tempArray2 addObject:clickdic[imageName]];
                
            }
            self.clickArray = tempArray2;
            
            NSLog(@"%@",self.clickArray);
            //            [self.rocationCollectionView reloadData];
        }
        
        
        
    });
    
    
    
    
}
-(void)addCollectionView{
    //设置UICollectionView的属性
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置为水平滚动
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    //设置每个cell的size
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    [layout setItemSize:CGSizeMake(screenW, 150)];
    //去除每个cell之间的距离
    [layout setMinimumInteritemSpacing:0];
    [layout setMinimumLineSpacing:0];
    
    //设置每个UICollectionView的frame
    CGFloat rocationCollectionH = 150;
    UICollectionView *rocationCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, screenW, rocationCollectionH) collectionViewLayout:layout];
    //设置数据源
    rocationCollection.dataSource = self;
    rocationCollection.backgroundColor = [UIColor redColor];
    //设置UICollectionView的属性
    rocationCollection.pagingEnabled = YES;
    rocationCollection.showsHorizontalScrollIndicator = NO;
    //将UICollectionView添加到parentScrollView
    [self.parentScrollView addSubview:rocationCollection];
    
    //设置代理
    rocationCollection.delegate = self;
    
    self.rocationCollectionView = rocationCollection;
    
    //注册UICollectionViewCell
    UINib *nid = [UINib nibWithNibName:@"RocationCollectionViewCell" bundle:nil];
    [rocationCollection registerNib:nid forCellWithReuseIdentifier:@"rocationCollectionViewCell"];
    
}
-(void)addPageControl{
    //设置pageControl的属性
    UIPageControl *rocationPageControl = [[UIPageControl alloc]init];
    [rocationPageControl setCurrentPageIndicatorTintColor:[UIColor greenColor]];
    [rocationPageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
    
    rocationPageControl.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    
    //设置pageControl的frame
    CGFloat rocationPageControlH = 15;
    CGFloat rocationPageControlW = self.parentScrollView.bounds.size.width;
    CGFloat rocationPageControlX = 0;
    CGFloat rocationPageControlY = 150 - rocationPageControlH;
    rocationPageControl.frame = CGRectMake(rocationPageControlX, rocationPageControlY, rocationPageControlW, rocationPageControlH);
    
    
    self.rocationPageControl = rocationPageControl;
    //添加到parentScrollView
    [self.parentScrollView addSubview:rocationPageControl];
}
-(void)addTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}
//加载分类视图
-(void)addCategoryIcon{
    NSArray *icons = @[@"category1", @"category4", @"category2", @"category6"];
    int row = icons.count/4 + icons.count%4?1:0;
    NSLog(@"row = %d", row);
    UIView *categoryView = [[UIView alloc]init];
    _categoryView = categoryView;
    CGFloat categoryViewX = 0;
    CGFloat categoryViewY = self.rocationCollectionView.frame.size.height + 3;
    CGFloat categoryViewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat categoryViewH = 63.0*row;
    categoryView.frame = CGRectMake(categoryViewX, categoryViewY, categoryViewW, categoryViewH);
    
    for (int i = 0 ; i < icons.count; i++) {
        UIButton *categoryButton = [[UIButton alloc]init];
        
        
        CGFloat buttonw = 45;
        CGFloat buttonH = 60;
        CGFloat margin = (categoryViewW-(buttonw * 4))/5;
        int row = i/4;
        int column = i%4;
        CGFloat buttonX = margin+(buttonw+margin)*column;
        CGFloat buttonY = row * (buttonH + 3);
    
        UIImage *tempImage = [UIImage imageNamed:icons[i]];
        
        [categoryButton setImage:tempImage forState:UIControlStateNormal];
        categoryButton.frame = CGRectMake(buttonX, buttonY, buttonw, buttonH);
        categoryButton.tag = i;
        [categoryButton addTarget:self action:@selector(toCategoryController:) forControlEvents:UIControlEventTouchUpInside];
        [categoryView addSubview:categoryButton];
    }
    
    
    
    [self.parentScrollView addSubview:categoryView];
}
//加载网页
-(void)addWebView{
    UIWebView *mainWebView = [[UIWebView alloc]init];
    CGFloat webviewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat webviewH = [UIScreen mainScreen].bounds.size.width-276;
    mainWebView.frame = CGRectMake(0, _categoryView.y+_categoryView.height, webviewW, webviewH);
    self.mainWebView = mainWebView;
    
    NSURL *url = [NSURL URLWithString:@"http://www.ugohb.com/client2/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [mainWebView loadRequest:request];
    
    mainWebView.delegate = self;
    
    [self.parentScrollView addSubview:mainWebView];
}
-(void)nextPage{
    //获取当前正在显示的item
    NSIndexPath *currentIndexPath = [[self.rocationCollectionView indexPathsForVisibleItems]lastObject];
    //计算即将显示的item
    NSInteger nextItem = currentIndexPath.item+1;
    if (nextItem == 5000) {
        nextItem = 0;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:0];
    
    //滚动到下一个item
    [self.rocationCollectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    
    self.rocationPageControl.currentPage = nextItem % self.imageArray.count;
    
}
#pragma mark- UICollectionView数据源方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //设置rocationPageControl.numberOfPages，在此处设置是为了在刷新数据时候其数值能一起变化
    self.rocationPageControl.numberOfPages = self.imageArray.count;
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5000;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RocationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"rocationCollectionViewCell" forIndexPath:indexPath];
    
    RocationImage *rocationimage = [[RocationImage alloc]init];
    [rocationimage initWithString:self.imageArray[indexPath.item % self.imageArray.count]];
    
    cell.rocationimage = rocationimage;
    
    
    return cell;
    
}

#pragma mark- UICollectionView代理方法

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger select = indexPath.item;
    NSInteger tempcount = self.imageArray.count;
    NSInteger urlindex = select/tempcount;
    NSString *urlStr = self.clickArray[urlindex];
    [self toBusinessControllerWithURLString:urlStr];
    
}

#pragma mark-UIWebView的代理方法

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //点击网页链接后跳转到商家界面
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSMutableString *str = [NSMutableString stringWithString:request.URL.absoluteString];
        if ([str containsString:@"wap"]) {
             [str replaceCharactersInRange:[str rangeOfString:@"wap"] withString:@"client2"];
        }
        [self toBusinessControllerWithURLString:[str copy]];
        return NO;
    }
    return YES;
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //网页加载完毕后重新计算滚动视图的高度
    NSString *height = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
    CGFloat webViewHeight = [height floatValue];
    webView.frame = CGRectMake(0, _categoryView.y+_categoryView.height, [UIScreen mainScreen].bounds.size.width, webViewHeight);
    self.parentScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, webView.scrollView.contentSize.height+276-63);
    webView.scrollView.scrollEnabled = NO;
   
    CGFloat newHeight =  webView.scrollView.contentSize.height;
    
    webView.frame = CGRectMake(0, _categoryView.height+_categoryView.y, [UIScreen mainScreen].bounds.size.width, newHeight);
    self.parentScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, newHeight+276-63);
    
    
}


//跳转到分类界面
- (void)toCategoryController:(UIButton *)button {
    if (button.tag == 3) {
        AllCategoryController *allCate = [AllCategoryController new];
        [self.navigationController pushViewController:allCate animated:YES];
        return;
    }
    BusinessListController *businessList = [BusinessListController new];
    if (button.tag == 0) {
        businessList.title = @"打折";
        businessList.urlStr = @"http://www.ugohb.com/client/diszhe.php?did=1";
    } else {
        Cate *cate = [Cate new];
        if (button.tag == 1) {
            cate.name = @"服装";
            cate.ID = @"2";
        } else if (button.tag == 2) {
            cate.name = @"商超";
            cate.ID = @"3";
        }
        businessList.cate = cate;
    }
    [self.navigationController pushViewController:businessList animated:YES];
    
}
//根据给定的商家URL跳转到商家界面
- (void)toBusinessControllerWithURLString:(NSString *)urlStr {
    BusinessWebController *business = [BusinessWebController new];
    business.urlStr = urlStr;
    [self.navigationController pushViewController:business animated:YES];
}
@end
