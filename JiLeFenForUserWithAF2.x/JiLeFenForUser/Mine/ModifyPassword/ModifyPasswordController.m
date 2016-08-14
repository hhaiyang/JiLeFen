//
//  ModifyPasswordController.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ModifyPasswordController.h"
#import "ModifyPasswordCell.h"
#import "User.h"

@interface ModifyPasswordController ()
@property (nonatomic, weak) UITextField *passwordTextField;
@property (nonatomic, weak) UITextField *pwdxinTextField;
@property (nonatomic, weak) UITextField *pwdsureTextField;
@end

@implementation ModifyPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"修改登录密码";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(toForwardVC) imageName:@"二级页面返回小图标" height:30];
    
    NSArray *placehold = @[@"请输入原密码", @"请输入新密码", @"请确认新密码"];
    ModifyPasswordCell *cell = nil;
    for (int index = 0; index < 3; index++) {
        cell = [[ModifyPasswordCell alloc] initWithFrame:CGRectMake(0, 64+index*50, self.view.width, 50)];
        cell.inputTextField.placeholder = placehold[index];
        if (index == 0) {
            self.passwordTextField = cell.inputTextField;
            
        } else if (index == 1) {
            self.pwdxinTextField = cell.inputTextField;
        } else {
            self.pwdsureTextField = cell.inputTextField;
        }
        [self.view addSubview:cell];
    }
    
    UIButton *modifyPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"修改登陆密码-修改小图标"];
    CGFloat height = 40;
    CGFloat width = image.size.width / image.size.height * height;
    [modifyPasswordButton setBackgroundImage:image forState:UIControlStateNormal];
    modifyPasswordButton.frame = CGRectMake((self.view.width-width)/2, cell.y+cell.height+15, width, height);
    [modifyPasswordButton addTarget:self action:@selector(modifyPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:modifyPasswordButton];
    
    
   
}
- (void)modifyPassword {
    [self.view endEditing:YES];
    __weak typeof(self) weakSelf = self;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    if (self.passwordTextField.text.length <= 0) {
        hud.label.text = @"请输入原密码";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    if (self.pwdxinTextField.text.length <= 0) {
        hud.label.text = @"请输入新密码";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
        
    }
    if (self.pwdsureTextField.text.length <= 0) {
        hud.label.text = @"请确认新密码";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    if (![self.pwdxinTextField.text isEqualToString:self.pwdsureTextField.text]) {
        hud.label.text = @"新密码和确认密码不一致";
        [hud hideAnimated:YES afterDelay:1.5];
        return;
    }
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"修改中，请稍候";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"userid"] = [User currentUser].ID;
    para[@"password"] = self.passwordTextField.text;
    para[@"pwdxin"] = self.pwdxinTextField.text;
    para[@"pwdsure"] = self.pwdsureTextField.text;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=pwdup" parameters:para success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TEST_LOG(@"res = %@", responseObject);
        hud.mode = MBProgressHUDModeText;
        weakSelf.passwordTextField.text = nil;
        weakSelf.pwdxinTextField.text = nil;
        weakSelf.pwdsureTextField.text = nil;
        int status = [responseObject[@"status"] intValue];
        if (status == 1) {
            hud.label.text = @"密码修改成功";
            [hud hideAnimated:YES afterDelay:1.5];
            return ;
        }
        if (status == -2) {
            hud.label.text = @"修改失败：用户名或者密码不正确";
            [hud hideAnimated:YES afterDelay:1.5];
            return;
        }
        if (status == -1) {
            hud.label.text=  @"修改失败：确认密码输入有误";
            [hud hideAnimated:YES afterDelay:1.5];
            return;
        }
        if (status == 0) {
            hud.label.text = @"修改失败：两次密码输入相同";
            [hud hideAnimated:YES afterDelay:1.5];
            return;
        }
        hud.label.text = @"修改失败";
        [hud hideAnimated:YES afterDelay:1.5];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        TEST_LOG(@"error = %@", error);
        weakSelf.passwordTextField.text = nil;
        weakSelf.pwdxinTextField.text = nil;
        weakSelf.pwdsureTextField.text = nil;
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"修改密码失败";
        [hud hideAnimated:YES afterDelay:1.5];
        
    }];
    
}
- (void)toForwardVC {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
