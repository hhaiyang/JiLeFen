//
//  NotGetCell.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  未领取cell的样式
 */
@interface NotGetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *lookConvertCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *unsubscribeButton;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
