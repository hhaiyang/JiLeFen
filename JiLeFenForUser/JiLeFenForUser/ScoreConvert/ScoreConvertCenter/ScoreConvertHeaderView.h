//
//  ScoreConvertHeaderView.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/3/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreConvertHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cashConvertButton;
@property (weak, nonatomic) IBOutlet UIButton *domesticConvertButton;
@property (weak, nonatomic) IBOutlet UIButton *convertRecordButton;
+ (instancetype)headerView;
@end
