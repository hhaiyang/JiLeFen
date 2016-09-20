//
//  CashConvertController.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bank.h"

//现金兑换
@interface CashConvertController : UIViewController
//银行开户行类型
@property (nonatomic, strong) UILabel *bankLabel;
@property (nonatomic, strong) Bank *bank;
@end
