//
//  SuspendView.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  底部悬浮提示积分数视图
 */
@interface SuspendView : UIView
@property (weak, nonatomic) IBOutlet UILabel *myScoreLabel;
+ (instancetype)suspendView;
@end
