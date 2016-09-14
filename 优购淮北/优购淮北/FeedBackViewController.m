//
//  FeedBackViewController.m
//  优购淮北
//
//  Created by 李峰峰 on 15/8/21.
//  Copyright (c) 2015年 李峰峰. All rights reserved.
//

#import "FeedBackViewController.h"
#import "MBProgressHUD+MJ.h"

@interface FeedBackViewController ()
@property (strong, nonatomic) IBOutlet UITextView *contentText;
@property (strong, nonatomic) IBOutlet UITextField *emailText;
- (IBAction)sendButton;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}



- (IBAction)sendButton {
    
    self.contentText.text = @"";
    self.emailText.text = @"";
    [MBProgressHUD showSuccess:@"发送成功，感谢您的反馈！"];
}
@end
