//
//  Activity.h
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Activity : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *img_path;
@property (nonatomic, copy) NSString *begintime;
@property (nonatomic, copy) NSString *endtime;
@property (nonatomic, copy) NSString *hit;
@end
