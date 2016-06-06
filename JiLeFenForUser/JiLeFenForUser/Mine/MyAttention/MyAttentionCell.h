//
//  MyAttentionCell.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAttentionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myAttentionImageView;
@property (weak, nonatomic) IBOutlet UILabel *myAttentionTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelAttentionButton;
+ (instancetype)myAttentionCellWithTableView:(UITableView *)tableView;
@end
