//
//  MineHeaderView.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *myScoreButton;
@property (weak, nonatomic) IBOutlet UIButton *myAttentionButton;
@property (weak, nonatomic) IBOutlet UIButton *myRelatedAccountButton;
+ (instancetype)headerView;
@end
