//
//  CategoryCell.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCell : UITableViewCell
/** 分类名字 */
@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;
/** 更多 */
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
