//
//  BaseScrollViewController.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseScrollViewController : BaseViewController

/**
 *  BaseScrollViewController下的子视图,都放在mainView上面
 */
@property (nonatomic, strong) UIScrollView *mainView;

@end
