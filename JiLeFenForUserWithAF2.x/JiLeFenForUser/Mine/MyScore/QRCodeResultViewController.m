//
//  QRCodeResultViewController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QRCodeResultViewController.h"
#import "ImageManager.h"

@interface QRCodeResultViewController ()

- (void)initNavbar;
- (void)initViews;
- (void)copyButtonClicked:(id)sender;

@end

@implementation QRCodeResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavbar];
    [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)initNavbar
{
    self.navBarView.title = @"扫描结果";
    self.navBarView.leftButtonItem = [self backButtonItem];
}

- (void)initViews
{
    CGFloat gap = 10;
    CGFloat texviewHeight = 130;
    CGRect textViewFrame = CGRectMake(gap,
                                      gap,
                                      self.mainView.frame.size.width - 2 * gap,
                                      texviewHeight);
    UITextView *tmpTextView = [[UITextView alloc] initWithFrame:textViewFrame];
    tmpTextView.layer.cornerRadius = 3;
    tmpTextView.font = [UIFont systemFontOfSize:14];
    tmpTextView.text = self.qrText;
    tmpTextView.editable = NO;
    [self.mainView addSubview:tmpTextView];
    
    HYButton *copyQRButton = [HYButton buttonWithType:UIButtonTypeCustom];
    copyQRButton.frame = CGRectMake(20,
                                    gap + texviewHeight + 20,
                                    self.mainView.frame.size.width - 2 * 20,
                                    44);
    [copyQRButton setTitle:@"复制到粘帖板"
                  forState:UIControlStateNormal];
    UIImage* normalImage = [ImageManager imageNamed:@"test_bluebutton_nor"
                                             resize:UIEdgeInsetsMake(2, 2, 2, 2)];
    UIImage* highlightImage = [ImageManager imageNamed:@"test_bluebutton_high"
                                                resize:UIEdgeInsetsMake(2, 2, 2, 2)];
    [copyQRButton setBackgroundImage:normalImage
                            forState:UIControlStateNormal];
    [copyQRButton setBackgroundImage:highlightImage
                            forState:UIControlStateHighlighted];
    [copyQRButton addTarget:self
                     action:@selector(copyButtonClicked:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:copyQRButton];
}

- (void)copyButtonClicked:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.qrText];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"复制成功"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
}

@end
