//
//  ScanQRCodeController.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/6/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ScanQRCodeController.h"
#import <AVFoundation/AVFoundation.h>
#import "ConsumeScoreSuccessController.h"

#define ScanWidth 220
#define ScanHeight 220
#define OutScanAlpha 0.2



@interface ScanQRCodeController () <AVCaptureMetadataOutputObjectsDelegate> {
    UIView *_QrCodeline;
    UIView *_QrCodeline1;
    NSTimer *_timer;
}
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preview;
@end

@implementation ScanQRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫一扫";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(toForwardVC) imageName:@"二级页面返回小图标" height:30];
    
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setRectOfInterest:CGRectMake((self.view.height-ScanHeight)/2/self.view.height, (self.view.width-ScanWidth)/2/self.view.width, ScanHeight/self.view.height, ScanWidth/self.view.width)];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:_input]) {
        [_session addInput:_input];
    }
    if ([_session canAddOutput:_output]) {
        [_session addOutput:_output];
    }
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity =AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    [_session startRunning];
    
    [self setScanView];
    [self createTimer];


}
- (void)setScanView {
    UIView *scanView = [UIView new];
    scanView.layer.borderWidth = 1;
    scanView.layer.borderColor = [[UIColor greenColor] CGColor];
    scanView.frame = CGRectMake((self.view.width-ScanWidth)/2, (self.view.height-ScanHeight)/2, ScanWidth, ScanHeight);
    [self.view addSubview:scanView];
    
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor whiteColor];
    topView.alpha = OutScanAlpha;
    topView.frame = CGRectMake(0, 64, self.view.width, scanView.origin.y-64);
    [self.view addSubview:topView];
    
    UIView *leftView = [UIView new];
    leftView.backgroundColor = [UIColor whiteColor];
    leftView.alpha = OutScanAlpha;
    leftView.frame = CGRectMake(0, scanView.origin.y, scanView.origin.x, ScanHeight);
    [self.view addSubview:leftView];
    
    UIView *rightView = [UIView new];
    rightView.backgroundColor = [UIColor whiteColor];
    rightView.alpha = OutScanAlpha;
    rightView.frame = CGRectMake(scanView.x+scanView.width, scanView.y, leftView.width, leftView.height);
    [self.view addSubview:rightView];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.alpha = OutScanAlpha;
    bottomView.frame = CGRectMake(0, scanView.y+scanView.height, self.view.width, self.view.height-scanView.y-scanView.height);
    [self.view addSubview:bottomView];
    
    UILabel *labIntroudction= [[UILabel alloc] init];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.frame=CGRectMake(0,5, bottomView.width,20);
    labIntroudction.numberOfLines=1;
    labIntroudction.font=[UIFont systemFontOfSize:15.0];
    labIntroudction.textAlignment=NSTextAlignmentCenter;
    labIntroudction.text=@"将二维码对准方框，即可自动扫描";
    [bottomView addSubview:labIntroudction];
    
    //画中间的基准线
    _QrCodeline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scanView.width, 1)];
    _QrCodeline.backgroundColor = [UIColor greenColor];
    [scanView addSubview:_QrCodeline];
    
    //画中间的基准线
    _QrCodeline1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scanView.width, 1)];
    _QrCodeline1.backgroundColor = [UIColor greenColor];
    [scanView addSubview:_QrCodeline1];
    
    // 先让第二根线运动一次,避免定时器执行的时差,让用户感到启动App后,横线就开始移动
    
    [UIView animateWithDuration:2.2 animations:^{
        
        _QrCodeline1.frame = CGRectMake(0, scanView.height, scanView.width, 1);
    }];


}
- (void)createTimer {
    _timer=[NSTimer scheduledTimerWithTimeInterval:2.2 target:self selector:@selector(moveUpAndDownLine) userInfo:nil repeats:YES];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSString *stringValue = nil;
    if ([metadataObjects count] >0)
    {
        //停止扫描
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        [self toConsumeScoreSuccessVC];
    }
    
}
- (void)toForwardVC {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)moveUpAndDownLine
{
    CGFloat Y = _QrCodeline.frame.origin.y;
    if (Y == 0) {
        [UIView animateWithDuration:2.2 animations:^{
            
            _QrCodeline.frame = CGRectMake(0, ScanHeight, ScanWidth, 1);
        }];
        _QrCodeline1.frame = CGRectMake(0, 0, ScanWidth, 1);
    }
    else if (Y == ScanHeight) {
        _QrCodeline.frame = CGRectMake(0, 0, ScanWidth, 1);
        [UIView animateWithDuration:2.2 animations:^{
            
            _QrCodeline1.frame = CGRectMake(0, ScanHeight, ScanWidth, 1);
        }];
    }
    
}
- (void)toConsumeScoreSuccessVC {
    ConsumeScoreSuccessController *success = [ConsumeScoreSuccessController new];
    [self.navigationController pushViewController:success animated:YES];
}
@end
