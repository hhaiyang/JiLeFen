//
//  QRCodeScanViewController.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QRCodeScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "QRCodeScan.h"
#import "QRCodeResultViewController.h"
#import "HYBarButtonItem.h"
#import "ImageManager.h"
#import "NSString+Addition.h"

@interface QRCodeScanViewController () <AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImageView *animationView;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@property (nonatomic, assign) BOOL isScanning;
@property (nonatomic, assign) int marginTop;

- (void)registerNotification;
- (void)initNavbar;
- (void)initViews;
- (void)initCapture;
- (void)startScanning;
- (void)stopScanning;
- (void)onLightClicked:(id)sender;
- (void)onPhotoClicked:(id)sender;
- (void)startScanAnimation;
- (void)actionAfterQRScan:(NSString *)aString;

@end

@implementation QRCodeScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self registerNotification];
    [self initNavbar];
    [self initCapture];
    [self initViews];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self startScanAnimation];
    [self startScanning];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self stopScanning];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Private Methods

- (void)initNavbar
{
    //self.navigationController.navigationBar.hidden = YES;
    self.navBarView.title = @"扫一扫";
    self.navBarView.leftButtonItem = [self backButtonItem];
    HYBarButtonItem *tmpRightButtonItem = [[HYBarButtonItem alloc] initWithTitle:@"相册"
                                                                                    target:self
                                                                                    action:@selector(onPhotoClicked:)];
    self.navBarView.rightButtonItem = tmpRightButtonItem;
}


- (void)initCapture
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        self.captureSession = [[AVCaptureSession alloc] init];
        
        AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:nil];
        if (captureInput)
        {
            [self.captureSession addInput:captureInput];
            
            AVCaptureVideoDataOutput *captureOutput = [[AVCaptureVideoDataOutput alloc] init];
            captureOutput.alwaysDiscardsLateVideoFrames = YES;
            
            
            if (IOS7_OR_LATER)
            {
                AVCaptureMetadataOutput *metadataOutput=[[AVCaptureMetadataOutput alloc]init];
                [metadataOutput setMetadataObjectsDelegate:self
                                                     queue:dispatch_get_main_queue()];
                [self.captureSession setSessionPreset:AVCaptureSessionPresetHigh];
                [self.captureSession addOutput:metadataOutput];
                metadataOutput.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
            }
            else
            {
                [captureOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
                
                NSString* key = (NSString *)kCVPixelBufferPixelFormatTypeKey;
                NSNumber* value = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
                NSDictionary *videoSettings = [NSDictionary dictionaryWithObject:value forKey:key];
                [captureOutput setVideoSettings:videoSettings];
                [self.captureSession addOutput:captureOutput];
                
                NSString* preset = 0;
                if (NSClassFromString(@"NSOrderedSet") &&
                    [UIScreen mainScreen].scale > 1 &&
                    [inputDevice supportsAVCaptureSessionPreset:AVCaptureSessionPresetiFrame960x540])
                {
                    preset = AVCaptureSessionPresetiFrame960x540;
                }
                if (!preset)
                {
                    preset = AVCaptureSessionPresetMedium;
                }
                self.captureSession.sessionPreset = preset;
            }
        }
        else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"请进入设置,允许访问相机"
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
            
            [alertView show];
        }
    }
}

- (void)initViews
{
    if (self.captureSession)
    {
        self.captureVideoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        self.captureVideoPreviewLayer.frame = self.contentViewFrame;
        self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.view.layer addSublayer: self.captureVideoPreviewLayer];
    }
    
    if(IOS5_OR_LATER)
    {
        _marginTop = 70;
    }
    else
    {
        _marginTop = 50;
    }
    CGFloat orignY = CGRectGetMaxY(self.navBarView.frame);
    CGRect  topImageRect = CGRectMake(0, orignY, kScreenWidth, _marginTop);
    UIImage *topImage = [ImageManager imageNamed:@"test_qrcode_scan_background"];
    UIImageView *topbgView = [[UIImageView alloc] initWithFrame:topImageRect];
    topbgView.image = topImage;
    [self.view addSubview:topbgView];
    
    UIImage *scaBgImage = [ImageManager imageNamed:@"test_qrcode_scan_bg" resize:UIEdgeInsetsMake(0, 100, 0, 100)];
    CGRect  bgImageRect = CGRectMake(0, _marginTop + orignY, kScreenWidth, scaBgImage.size.height);
    UIImageView *bgView = [[UIImageView alloc] initWithFrame: bgImageRect];
    bgView.image = scaBgImage;
    [self.view addSubview:bgView];
    
    CGRect tipsFrame = CGRectMake((kScreenWidth - 320) / 2.0,
                                  CGRectGetMaxY(bgImageRect) - 40,
                                  320,
                                  40);
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:tipsFrame];
    tipsLabel.text = @"对准二维码，即可自动扫描。";
    tipsLabel.textColor = [UIColor whiteColor];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.font=[UIFont systemFontOfSize:12];
    tipsLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tipsLabel];
    
    //其他部分 用图片填充
    CGFloat bottomOriginY = CGRectGetMaxY(bgImageRect);
    CGRect bottomImageFrame = CGRectMake(0, bottomOriginY, kScreenWidth, kScreenHeight - bottomOriginY);
    UIImage *bottomImage = [ImageManager imageNamed:@"test_qrcode_scan_background"];
    UIImageView *bottombgView = [[UIImageView alloc] initWithFrame:bottomImageFrame];
    bottombgView.image = bottomImage;
    [self.view addSubview:bottombgView];
}

- (void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(startScanAnimation)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
}

- (void)startScanning
{
    if (!self.isScanning)
    {
        self.isScanning = YES;
        [self.captureSession startRunning];
    }
}

- (void)stopScanning
{
    if (self.isScanning)
    {
        self.isScanning = NO;
        [self.captureSession stopRunning];
    }
    if (self.animationView != nil) {
        [self.animationView removeFromSuperview];
    }
}

- (void)actionAfterQRScan:(NSString *)aString
{
    [self stopScanning];
    
    if (self.isFromJSWeb)
    {
        [self.navigationController popViewControllerAnimated:NO];
        self.scanActionBlock(aString);
    }
    else
    {
        QRCodeResultViewController *testQRResultController = [[QRCodeResultViewController alloc] init];
        testQRResultController.qrText = aString;
        [self.navigationController pushViewController:testQRResultController animated:YES];
    }
}

//开启扫描动画
- (void)startScanAnimation
{
    [self.animationView removeFromSuperview];
    
    UIImageView *tmpAnimationView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 320) / 2.0 + 50,
                                                                                  _marginTop + NAV_BAR_HEIGHT +STATUS_GAP + 60,
                                                                                  220,
                                                                                  2)];
    tmpAnimationView.image = [ImageManager imageNamed:@"test_qrcode_scan_animation"];
    self.animationView = tmpAnimationView;
    [self.view addSubview:self.animationView];
    
    [UIView animateWithDuration:1.0
                          delay:0
                        options:UIViewKeyframeAnimationOptionRepeat | UIViewKeyframeAnimationOptionAutoreverse
                     animations:^{
                         self.animationView.frame = CGRectMake((kScreenWidth - 320) / 2.0 + 50,
                                                               _marginTop + NAV_BAR_HEIGHT+STATUS_GAP + 260,
                                                               220,
                                                               2);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

//开灯
- (void)onLightClicked:(id)sender
{
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if (device.torchMode==AVCaptureTorchModeOff)
    {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOn];
        
    }else
    {
        [device setTorchMode:AVCaptureTorchModeOff];
    }
}

//打开相册
- (void)onPhotoClicked:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:^{
        [self stopScanning];
    }];
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate

// iOS6系统触发
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    UIImage *captureImage = [QRCodeScan imageFromSampleBuffer:sampleBuffer];
    NSString *qrString = [QRCodeScan decodeFromQRImage:captureImage];
    if (![NSString strNilOrEmpty:qrString])
    {
        [self actionAfterQRScan:qrString];
    }
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate

// IOS7及其以上的iOS系统触发
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count>0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        if (![NSString strNilOrEmpty:metadataObject.stringValue])
        {
            [self actionAfterQRScan:metadataObject.stringValue];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 NSString *qrString = [QRCodeScan decodeFromQRImage:image];
                                 if (![NSString strNilOrEmpty:qrString])
                                 {
                                     [self actionAfterQRScan:qrString];
                                 }
                                 
                                 [self startScanning];
                             }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self startScanning];
    }];
}

@end
