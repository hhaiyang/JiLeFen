//
//  QRCodeScanViewController.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BaseViewController.h"
/**
 *  二维码扫描界面
 */
@interface QRCodeScanViewController : BaseViewController
@property (copy) void (^scanActionBlock)(NSString *scanResult);
@property (assign) BOOL isFromJSWeb;

@end

