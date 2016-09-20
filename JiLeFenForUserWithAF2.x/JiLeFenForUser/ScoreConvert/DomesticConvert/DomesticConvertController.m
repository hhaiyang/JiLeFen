//
//  DomesticServiceController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "DomesticConvertController.h"
#import "AppointmentingController.h"
#import "IntroductionView.h"
#import "AppointmentedController.h"
#import "AppointmentCell.h"
#import "AppointmentHintView.h"
#import "AppointmentInfoView.h"
#import "AppointmentSuccessView.h"
#import "AccountValidate.h"
#import "User.h"
@interface DomesticConvertController () <AppointmentHintViewDelegate, AppointmentInfoViewDelegate, AppointmentSuccessViewDelegate>
@property (nonatomic, strong) UILabel *freeScoreLabel;
@property (nonatomic, strong) UILabel *appointmentingLabel;
@property (nonatomic, strong) UILabel *appointmentedLabel;

//弹出框
@property (nonatomic, strong) AppointmentHintView *appointmentHintView;
@property (nonatomic, strong) AppointmentInfoView *appointmentInfoView;
@property (nonatomic, strong) AppointmentSuccessView *appointmentSuccessView;
@end

@implementation DomesticConvertController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDomesticTimeSet];
    self.title = @"家政兑换";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(backAction) imageName:@"返回小图标-红色" height:30];
    
    UIView *tableHeaderView = [UIView new];
    tableHeaderView.frame = CGRectMake(0, 0, self.tableView.width, 55+25+40);
    self.tableView.tableHeaderView = tableHeaderView;
    
    UIView *freeScoreView = [UIView new];
    freeScoreView.backgroundColor = kRGBColor(232, 232, 232);
    freeScoreView.frame = CGRectMake(10, 10, tableHeaderView.width-20, 45);
    [tableHeaderView addSubview:freeScoreView];
    
    CGFloat space = (freeScoreView.width-2)/3;
    for (int index = 0; index < 2; index++) {
        UIView *line = [UIView new];
        line.backgroundColor = kRGBColor(214, 214, 214);
        line.frame = CGRectMake(space+index*(space+1), 10, 1, freeScoreView.height-20);
        [freeScoreView addSubview:line];
    }
    
    for (int index = 0; index < 3; index++) {
        UILabel *label = [UILabel new];
        label.userInteractionEnabled = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(freeScoreView.width/3*index, 0, freeScoreView.width/3, freeScoreView.height);
        [freeScoreView addSubview:label];
        if (index == 0) {
            _freeScoreLabel = label;
            NSMutableAttributedString *str = [NSMutableAttributedString new];
            NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"免费积分 " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9]}];
            NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"5899" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20], NSForegroundColorAttributeName:[UIColor redColor]}];
            [str appendAttributedString:str1];
            [str appendAttributedString:str2];
            _freeScoreLabel.attributedText = str;
        } else if (index == 1) {
            _appointmentingLabel = label;
            NSMutableAttributedString *str = [NSMutableAttributedString new];
            NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"预约中  " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9]}];
            NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"1" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20], NSForegroundColorAttributeName:kRGBColor(0, 174, 156)}];
            [str appendAttributedString:str1];
            [str appendAttributedString:str2];
            _appointmentingLabel.attributedText = str;
            
            UITapGestureRecognizer *appointmentingGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toAppointmentingVC:)];
            [label addGestureRecognizer:appointmentingGR];
            
        } else {
            _appointmentedLabel = label;
            NSMutableAttributedString *str = [NSMutableAttributedString new];
            NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"已完成  " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9]}];
            NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"2" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20], NSForegroundColorAttributeName:[UIColor redColor]}];
            [str appendAttributedString:str1];
            [str appendAttributedString:str2];
            _appointmentedLabel.attributedText = str;
            
            UITapGestureRecognizer *appointmentedGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toAppointmentedVC:)];
            [label addGestureRecognizer:appointmentedGR];
            
        }
    }
    
    //小喇叭视图
    UIView *loudspeakerView = [UIView new];
    loudspeakerView.frame = CGRectMake(freeScoreView.x, freeScoreView.y+freeScoreView.height+5, tableHeaderView.width-freeScoreView.x*2, 20);
    [tableHeaderView addSubview:loudspeakerView];
    UIImageView *loudspeakerImageView = [UIImageView new];
    UIImage *image = [UIImage imageNamed:@"Loudspeaker"];
    CGFloat height = loudspeakerView.height-5;
    CGFloat width = image.size.width/image.size.height*height;
    loudspeakerImageView.frame = CGRectMake(0, 2.5, width, height);
    loudspeakerImageView.image = image;
    [loudspeakerView addSubview:loudspeakerImageView];
    UILabel *loudspeakerLabel = [UILabel new];
    loudspeakerLabel.text = @"免费家政包含淮北市内130平米以内的房子清洁打扫，消减免费积分2000分！";
    loudspeakerLabel.textColor = [UIColor redColor];
    loudspeakerLabel.font = [UIFont systemFontOfSize:8];
    loudspeakerLabel.frame = CGRectMake(loudspeakerImageView.x+loudspeakerImageView.width, 0, loudspeakerView.width-loudspeakerImageView.width-loudspeakerImageView.x, loudspeakerView.height);
    [loudspeakerView addSubview:loudspeakerLabel];
    
    //选择日期的视图
    UIView *selectDateView = [UIView new];
    selectDateView.frame = CGRectMake(10, loudspeakerView.y+loudspeakerView.height+5, tableHeaderView.width-20, 35);
    [tableHeaderView addSubview:selectDateView];
    UIView *line = [UIView new];
    line.frame = CGRectMake(0, selectDateView.height-2, selectDateView.width, 2);
    line.backgroundColor = kRGBColor(217, 217, 217);
    [selectDateView addSubview:line];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton addTarget:self action:@selector(scrollBack:) forControlEvents:UIControlEventTouchUpInside];
    image = [UIImage imageNamed:@"LeftScrollButton"];
    height = 25;
    width = image.size.width/image.size.height*height;
    [leftButton setBackgroundImage:image forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, width, height);
    [selectDateView addSubview:leftButton];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    image = [UIImage imageNamed:@"RightScrollButton"];
    [rightButton setBackgroundImage:image forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(scrollForward:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(selectDateView.width-leftButton.width, 0, leftButton.width, leftButton.height);
    [selectDateView addSubview:rightButton];
    //选择日期的滚动视图
    UIScrollView *dateScrollView = [UIScrollView new];
    dateScrollView.showsHorizontalScrollIndicator = NO;
    dateScrollView.frame = CGRectMake(leftButton.width+10, 0, selectDateView.width-leftButton.width*2-20, leftButton.height);
    width = selectDateView.width-leftButton.width*2-20;
    height = leftButton.height;
    dateScrollView.contentSize = CGSizeMake((width-20)/3*7+60, height);
    [selectDateView addSubview:dateScrollView];
    width = (dateScrollView.contentSize.width-60)/7;
    for (int i = 0; i < 7; i++) {
        UIButton *dateButton = [UIButton buttonWithType:UIButtonTypeSystem];
        dateButton.layer.cornerRadius = 8;
        [dateButton setTitle:@"周一12月31日" forState:UIControlStateNormal];
        dateButton.titleLabel.font = [UIFont systemFontOfSize:10];
        dateButton.frame = CGRectMake(i*(width+10), 4, width, dateScrollView.height-8);
        [dateScrollView addSubview:dateButton];
    }
    
    
    
    IntroductionView *introView = [[IntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 200)];
    introView.titleLabel.text = @"  温馨提示：";
    introView.titleLabel.textColor = [UIColor redColor];
    introView.detailTextView.text = @"1、免费积分和现金积分分为单独的两个系统；\n2、免费积分中兑换的服务是积了分额外赠送给会员使用的，削减免费积分2000分。例如：您在积了分APP上积分5000分，您可以在现金兑换窗口兑换现金50元，剩余积分为0分，额外在本免费积分窗口兑换家政服务2次，剩余免费积分1000分；如果您未兑换家政，又积分2000分，您的剩余积分为2000分，在现金兑换专区可兑换20元，免费积分共有7000分，可兑换家政服务3次，只要在本免费积分系统您未参与兑换，免费积分不会和兑换现金、物品一起削减掉。";
    self.tableView.tableFooterView = introView;
    
    [self.tableView registerClass:[AppointmentCell class] forCellReuseIdentifier:@"AppointmentCell"];
    
    
}
- (void)toAppointmentingVC:(id)sender {
    AppointmentingController *appointmentController = [AppointmentingController new];
    [self.navigationController pushViewController:appointmentController animated:YES];
}
- (void)toAppointmentedVC:(UITapGestureRecognizer *)sender {
    AppointmentedController *appointmented = [AppointmentedController new];
    [self.navigationController pushViewController:appointmented animated:YES];
    
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppointmentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppointmentCell"];
    [cell.appointmentButton addTarget:self action:@selector(appointment:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}
- (void)scrollBack:(UIButton *)sender {
    TEST_LOG(@"向后滚动");
}
- (void)scrollForward:(UIButton *)sender {
    TEST_LOG(@"向后滚动");
}

//点击预约按钮，弹出确认预约对话框
- (void)appointment:(UIButton *)sender {
    _appointmentHintView = [[AppointmentHintView alloc] init];
    _appointmentHintView.delegate = self;
    [kWindow addSubview:_appointmentHintView];
    
}
//预约确认弹出视图代理
- (void)appointmentHintView:(AppointmentHintView *)view didClickedCloseButton:(UIButton *)button {
    [view removeFromSuperview];
    _appointmentHintView = nil;
}
- (void)appointmentHintView:(AppointmentHintView *)view didClickedSureButton:(UIButton *)button {
    [view removeFromSuperview];
    _appointmentInfoView = [[AppointmentInfoView alloc] init];
    _appointmentInfoView.delegate = self;
    [kWindow addSubview:_appointmentInfoView];
    
}
- (void)appointmentHintView:(AppointmentHintView *)view didClickedCancelButton:(UIButton *)button {
    [view removeFromSuperview];
    _appointmentHintView = nil;
    
}

//填写预约信息视图的代理方法
- (void)appointmentInfoView:(AppointmentInfoView *)view didClickedCloseButton:(UIButton *)button {
    [view removeFromSuperview];
    _appointmentInfoView = nil;
    _appointmentHintView = nil;
}

//发送预约请求
- (void)appointmentInfoView:(AppointmentInfoView *)view didClickedSureButton:(UIButton *)button {
    __weak typeof(self) weakSelf = self;
    //获取用户输入
    NSString *username = view.nameTextField.text;
    NSString *phone = view.phoneTextField.text;
    NSString *address = view.addressTextField.text;
    //验证用户输入
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    if (username.length <= 0) {
        hud.label.text = @"请输入您的姓名";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    if (![AccountValidate validatePhone:phone]) {
        hud.label.text = @"请输入正确的手机号";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    if (address.length <= 0) {
        hud.label.text = @"请输入您的详细地址";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    //验证通过则发送预约请求
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"预约中，请稍候";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"realname"] = username;
    para[@"phone"] = phone;
    para[@"address"] = address;
    para[@"userid"] = [User currentUser].ID;
    para[@"servicetime"] = @"2016-9-20";
    para[@"timeset"] = @"18:00-20:00";
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=jzorder" parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        TEST_LOG(@"res = %@", responseObject);
//        int status = [responseObject[@"status"] intValue];
//        if (status == 0) {
//            hud.mode = MBProgressHUDModeText;
//            hud.label.text = @"预约失败";
//            [hud hideAnimated:YES afterDelay:1.5];
//            return ;
//        }
        
        //预约成功则弹出成功视图
        [hud hideAnimated:YES];
        [view removeFromSuperview];
        _appointmentSuccessView = [[AppointmentSuccessView alloc] init];
        _appointmentSuccessView.nameLabel.text = username;
        _appointmentSuccessView.phoneLabel.text = phone;
        _appointmentSuccessView.addressLabel.text = address;
        _appointmentSuccessView.delegate = weakSelf;
        [kWindow addSubview:_appointmentSuccessView];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        TEST_LOG(@"error = %@", error);
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"预约失败";
        [hud hideAnimated:YES afterDelay:1.5];
        
    }];
    
    
    
}
- (void)appointmentInfoView:(AppointmentInfoView *)view didClickedBackButton:(UIButton *)button {
    [view removeFromSuperview];
    _appointmentInfoView = nil;
    _appointmentHintView = nil;
    
}


- (void)appointmentSuccessView:(AppointmentSuccessView *)view didClickedCloseButton:(UIButton *)button{
    [view removeFromSuperview];
    _appointmentSuccessView = nil;
    _appointmentHintView = nil;
    _appointmentInfoView = nil;
}
- (void)appointmentSuccessView:(AppointmentSuccessView *)view didClickedSureButton:(UIButton *)button{
    [view removeFromSuperview];
    _appointmentSuccessView = nil;
    _appointmentHintView = nil;
    _appointmentInfoView = nil;
    
}
- (void)appointmentSuccessView:(AppointmentSuccessView *)view didClickedBackButton:(UIButton *)button {
    [view removeFromSuperview];
    _appointmentSuccessView = nil;
    _appointmentHintView = nil;
    _appointmentInfoView = nil;
    
}
//获取家政时间表
- (void)getDomesticTimeSet {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=jztimeset" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        TEST_LOG(@"res = %@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        TEST_LOG(@"error = %@", error);
        
    }];
}
@end
