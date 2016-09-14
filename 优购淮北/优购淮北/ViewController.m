//
//  ViewController.m
//  优购淮北
//
//  Created by 李峰峰 on 15/8/17.
//  Copyright (c) 2015年 李峰峰. All rights reserved.
//

#import "ViewController.h"
#import "RocationCollectionViewCell.h"
#import "RocationImage.h"
#import "ProductWebViewViewController.h"
#import "MainTabBarController.h"
#import "MBProgressHUD+MJ.h"




@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *parentScrollView;

@property (strong, nonatomic)UICollectionView  *rocationCollectionView;
@property(strong,nonatomic)UIPageControl *rocationPageControl;

- (IBAction)searchButtonClick;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property(strong,nonatomic)UIWebView *mainWebView;


@property(strong,nonatomic)NSMutableArray *imageArray;
@property(strong,nonatomic)NSMutableArray *clickArray;

//@property(strong,nonatomic)UILabel *clickText;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithObjects:@"http://www.ugohb.com/attachment/flash/1439454273cdfub.jpg", nil];
    self.imageArray = tempArray;
    
    [self getJSON];
    [self addCollectionView];
    [self addPageControl];
    [self addTimer];
    [self addCategoryIcon];
//    [self addWebView];
    


}

-(void)viewDidAppear:(BOOL)animated{
    CGFloat testheight = self.mainWebView.frame.size.height;
    if (testheight <200) {
        [self addWebView];
        NSLog(@"[self addWebView]");
    }
    
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

-(void)addWebView{
    UIWebView *mainWebView = [[UIWebView alloc]init];
    CGFloat webviewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat webviewH = [UIScreen mainScreen].bounds.size.width-276;
    mainWebView.frame = CGRectMake(0, 276, webviewW, webviewH);
    self.mainWebView = mainWebView;
    
    //加载测试URL
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"testindex.html" withExtension:nil];
    NSURL *url = [NSURL URLWithString:@"http://www.ugohb.com/client2/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [mainWebView loadRequest:request];
    
    mainWebView.delegate = self;
    
    [self.parentScrollView addSubview:mainWebView];
}

-(void)addCategoryIcon{
    UIView *categoryView = [[UIView alloc]init];
    CGFloat categoryViewX = 0;
    CGFloat categoryViewY = self.rocationCollectionView.frame.size.height + 3;
    CGFloat categoryViewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat categoryViewH = 126;
    categoryView.frame = CGRectMake(categoryViewX, categoryViewY, categoryViewW, categoryViewH);
//    categoryView.backgroundColor = [UIColor redColor];
    
    for (int i = 0 ; i < 8; i++) {
        UIButton *categoryButton = [[UIButton alloc]init];
        
       
        CGFloat buttonw = 45;
        CGFloat buttonH = 60;
        CGFloat margin = (categoryViewW-(buttonw * 4))/5;
        int row = i/4;
        int column = i%4;
        CGFloat buttonX = margin+(buttonw+margin)*column;
        CGFloat buttonY = row * (buttonH + 3);
        
        NSString *imageName = [NSString stringWithFormat:@"category%d",i+1];
        UIImage *tempImage = [UIImage imageNamed:imageName];
        
        [categoryButton setImage:tempImage forState:UIControlStateNormal];
        categoryButton.frame = CGRectMake(buttonX, buttonY, buttonw, buttonH);
//        categoryButton.backgroundColor = [UIColor greenColor];
        categoryButton.tag = i;
        [categoryButton addTarget:self action:@selector(categoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [categoryView addSubview:categoryButton];
    }
    
    
    
    [self.parentScrollView addSubview:categoryView];
}

-(void)categoryButtonClick:(UIButton *)button{

    if ([self.delegate respondsToSelector:@selector(categoryButtonclicked:)]) {
        [self.delegate categoryButtonclicked:button.tag];
    }
    
}

-(void)addTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
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
    int select = indexPath.item;
    int tempcount = self.imageArray.count;
    int urlindex = select/tempcount;
    NSLog([NSString stringWithFormat:@"点击了%d",urlindex]);
    NSString *clickurl = [[NSString alloc]init];
    clickurl = self.clickArray[urlindex];
    if ([self.delegate respondsToSelector:@selector(webviewLinkClicked:)]) {
    [self.delegate webviewLinkClicked:clickurl];
    }
    
}

#pragma mark-UIWebView的代理方法

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    
    NSString *temploadurl = [request.URL absoluteString];
    NSMutableString *loadurl = [NSMutableString stringWithString:temploadurl];
    BOOL toLoad = true;
    
    if (![loadurl isEqualToString:@"http://www.ugohb.com/client2/"]) {
       
        
        if([loadurl rangeOfString:@"wap"].location != NSNotFound){
        //链接中包含字符"wap",将其替换成client2
            [loadurl replaceCharactersInRange:[loadurl rangeOfString:@"wap"] withString:@"client2"];
        
        }
        
        if ([self.delegate respondsToSelector:@selector(webviewLinkClicked:)]) {
            toLoad = false;
            [self.delegate webviewLinkClicked:loadurl];

        }
    }

    return toLoad;
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *height = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
    CGFloat webViewHeight = [height floatValue];
//    NSLog([NSString stringWithFormat:@"webview的高度：%f",webViewHeight]);
    /////////////////出现奇葩的bug,这里必须这么写/////////////////
    webView.frame = CGRectMake(0, 276, [UIScreen mainScreen].bounds.size.width, webViewHeight);
    self.parentScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, webView.scrollView.contentSize.height+276);
    webView.scrollView.scrollEnabled = NO;
    ///////////////////
   CGFloat newHeight =  webView.scrollView.contentSize.height;
//    NSLog([NSString stringWithFormat:@"test = %f",test]);

    webView.frame = CGRectMake(0, 276, [UIScreen mainScreen].bounds.size.width, newHeight);
    self.parentScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, newHeight+276);
    
    
//    CGFloat test = self.mainWebView.frame.size.height;
//    NSLog(@"=====%f",test);
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD showError:@"没有网络连接"];
//    CGFloat test = self.mainWebView.frame.size.height;
//    NSLog(@"=====%f",test);
  
}

- (IBAction)searchButtonClick {
    NSString *encodeString = [self.searchTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"http://www.ugohb.com/client/serch.php?name=%@",encodeString];
    
    if ([self.delegate respondsToSelector:@selector(webviewLinkClicked:)]) {
        [self.delegate webviewLinkClicked:url];
    }
    
}
@end









