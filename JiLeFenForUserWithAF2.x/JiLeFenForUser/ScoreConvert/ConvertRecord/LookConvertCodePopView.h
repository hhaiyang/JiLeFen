//
//  LookConvertCodePopView.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  查看兑换码弹出框
 */
@interface LookConvertCodePopView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cornerCloseButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomCloseButton;
+ (instancetype)popView;
@end
