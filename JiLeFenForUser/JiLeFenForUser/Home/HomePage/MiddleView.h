//
//  CategoryView.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MiddleView : UIView
/** 积分 */
@property (weak, nonatomic) IBOutlet UIButton *integralButton;
/** 打折 */
@property (weak, nonatomic) IBOutlet UIButton *discountButton;
/** 商超 */
@property (weak, nonatomic) IBOutlet UIButton *shangchaoButton;
/** 所有分类 */
@property (weak, nonatomic) IBOutlet UIButton *allCategoryButton;
+ (instancetype)middleView;
@end
