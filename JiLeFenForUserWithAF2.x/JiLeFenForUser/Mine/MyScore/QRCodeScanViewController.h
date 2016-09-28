//
//  QRCodeScanViewController.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "HYBaseViewController.h"
/**
 *  二维码扫描界面
 */
@interface QRCodeScanViewController : HYBaseViewController
@property (copy) void (^scanActionBlock)(NSString *scanResult);
@property (assign) BOOL isFromJSWeb;

@end

