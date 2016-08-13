//
//  GoodsInfoController.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/26.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "GoodsInfoController.h"
#import "GoodsInfoView.h"
#import "VerifySuccessController.h"
#define DashLineColor kRGBColor(192, 192, 192)
#define GoodsInfoViewBorderColor kRGBColor(249, 169, 199)
#define GoodsContentTextColor kRGBColor(255, 150, 170)
@interface GoodsInfoController ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *categoryLabel;
@property (nonatomic, strong) UILabel *totalLabel;
@end

@implementation GoodsInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"确认信息";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(toForwardVC) imageName:@"二级页面返回小图标" height:30];
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = DEFAULT_VIEW_CONTROLLER_BACKGROUND_COLOR;
    contentView.frame = CGRectMake(0, 64, self.view.width, 190);
    [self.view addSubview:contentView];
    
    CGFloat width = 100;
    CGFloat height = 30;
    UILabel *label = [UILabel new];
    label.frame = CGRectMake((contentView.width-width)/2, 30, width, height);
    label.text = @"验证码正确";
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:label];
    
    UIView *dashView = [UIView new];
    dashView.frame = CGRectMake(30, label.y+label.height+20, contentView.width-60, 2);
    [ViewUtil drawDashLine:dashView lineLength:3 lineSpacing:2 lineColor:DashLineColor];
    [contentView addSubview:dashView];
    
    CGFloat horizontalSpace = (dashView.width-50-2)/2;
    CGFloat verticalSpace = 30+1;
    width = horizontalSpace+1;
    height = verticalSpace+1;
    NSArray *titles = @[@"名称", @"品类", @"数量", self.order.goods.name, @"花生巧克力口味", self.order.count];
    GoodsInfoView *goodsInfoView = nil;
    for (int index = 0; index < 6; index++) {
        if (index == 2 || index == 5) {
            width = 50+1;
        } else {
            width = horizontalSpace+1;
        }
        if (index / 3 == 1) {
            height = 35+1;
        }
        goodsInfoView = [[GoodsInfoView alloc] initWithFrame:CGRectMake(index%3*horizontalSpace+dashView.x, index/3*verticalSpace+dashView.y+dashView.height+20, width, height)];
        goodsInfoView.textLabel.text = titles[index];
        goodsInfoView.layer.borderWidth = 1;
        goodsInfoView.layer.borderColor = [GoodsInfoViewBorderColor CGColor];
        [contentView addSubview:goodsInfoView];
        if (index == 3) {
            goodsInfoView.textLabel.textColor = GoodsContentTextColor;
            self.nameLabel = goodsInfoView.textLabel;
            
        } else if (index == 4) {
            goodsInfoView.textLabel.textColor = GoodsContentTextColor;
            self.categoryLabel = goodsInfoView.textLabel;
        } else if (index == 5) {
            goodsInfoView.textLabel.textColor = GoodsContentTextColor;
            self.totalLabel = goodsInfoView.textLabel;
        }
    }
    
    UIView *actionView = nil;
    UIButton *button = nil;
    NSArray *images = @[@"物品兑换-确定验证", @"物品兑换-取消验证"];
    width = self.view.width/2;
    height = 50;
    CGFloat buttonWidth = 0;
    for (int index = 0; index < 2; index++) {
        actionView = [UIView new];
        actionView.frame = CGRectMake(index*width, contentView.y+contentView.height+50, width, height);
        [self.view addSubview:actionView];
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:images[index]];
        buttonWidth = image.size.width/image.size.height*height;
        button.frame = CGRectMake((actionView.width-buttonWidth)/2, 0, buttonWidth, height);
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [actionView addSubview:button];
        if (index == 0) {
            //确定验证
            [button addTarget:self action:@selector(confirmVerify) forControlEvents:UIControlEventTouchUpInside];
            
        } else {
            //取消验证
            [button addTarget:self action:@selector(cancelVerify) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    
    
}
- (void)toForwardVC {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)cancelVerify {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)confirmVerify {
    __weak typeof(self) weakSelf = self;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"验证中，请稍候";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"code"] = self.order.code;
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=surechange" parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        TEST_LOG(@"res = %@", responseObject);
        int status = [responseObject[@"status"] intValue];
        if (status == 1) {
            [hud hideAnimated:YES];
            [weakSelf toVerifySuccessVC];
            return ;
            
        }
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"验证失败";
        [hud hideAnimated:YES afterDelay:1.5];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        TEST_LOG(@"error = %@", error);
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"验证失败";
        [hud hideAnimated:YES afterDelay:1.5];
        
    }];
   
}
- (void)toVerifySuccessVC {
    VerifySuccessController *success = [VerifySuccessController new];
    [self.navigationController pushViewController:success animated:YES];
    
}
@end
