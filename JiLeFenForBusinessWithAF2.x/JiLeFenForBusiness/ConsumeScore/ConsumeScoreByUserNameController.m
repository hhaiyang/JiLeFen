//
//  ConsumeScoreByUserNameController.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/6/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ConsumeScoreByUserNameController.h"

@interface ConsumeScoreByUserNameController ()
@property (nonatomic, strong) UITextField *scoreTextField;
@property (nonatomic, strong) UITextField *userNameTextField;
@end

@implementation ConsumeScoreByUserNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消费积分";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(toForwardVC) imageName:@"二级页面返回小图标" height:30];
    UITextField *scoreTextField = [ViewUtil textFieldWithOrigin:CGPointMake(30, 100) width:self.view.width-60 placehold:@"请输入积分数额"];
    scoreTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.scoreTextField = scoreTextField;
    [self.view addSubview:scoreTextField];
    
    UITextField *userNameTextField = [ViewUtil textFieldWithOrigin:CGPointMake(30, scoreTextField.y+scoreTextField.height+5) width:self.view.width-60 placehold:@"请输入用户名"];
    self.userNameTextField = userNameTextField;
    [self.view addSubview:userNameTextField];
    
    CGFloat width = 70;
    CGFloat height = 30;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake((self.view.width-width)/2, userNameTextField.y+userNameTextField.height+30, width, height);
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    button.layer.cornerRadius = 5;
    [self.view addSubview:button];
    
    UITextView *textView = [UITextView new];
    textView.textColor = [UIColor grayColor];
    textView.font = [UIFont systemFontOfSize:15];
    textView.text = @"\t温馨提示：\n\t1、积分数额为消费者在您的店里购买商品的同等数额；\n\t2、用户名为积分用户注册时的用户名称，即为消费者的手机号码。";
    textView.userInteractionEnabled = NO;
    textView.frame = CGRectMake(0, button.y+button.height+70, self.view.width, self.view.height-button.y-button.height-70);
    [self.view addSubview:textView];
    
    
    
}
- (void)toForwardVC {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)submit {
    [self.view endEditing:YES];
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.mode = MBProgressHUDModeText;
//    if (self.scoreTextField.text.length <= 0) {
//        hud.label.text = @"请输入积分数额";
//        [hud hideAnimated:YES afterDelay:1.5];
//        return;
//    }
//    if (self.userNameTextField.text.length <= 0) {
//        hud.label.text = @"请输入用户名";
//        [hud hideAnimated:YES afterDelay:1.5];
//        return;
//    }
//    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.label.text = @"提交中，请稍候";
//    //缺少接口
    
    
    
}
@end
