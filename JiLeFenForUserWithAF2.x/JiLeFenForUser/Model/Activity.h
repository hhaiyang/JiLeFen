//
//  Activity.h
//  JiLeFenForUser
//
//  Created by hhy on 16/9/5.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Business.h"
//商家活动模型
@interface Activity : NSObject
//活动ID
@property (nonatomic, copy) NSString *ID;
//活动标题
@property (nonatomic, copy) NSString *title;
//活动缩略图
@property (nonatomic, copy) NSString *thumb;
//活动积分
@property (nonatomic, copy) NSString *integral;
//活动所属商家
@property (nonatomic, strong) Business *business;
@end
