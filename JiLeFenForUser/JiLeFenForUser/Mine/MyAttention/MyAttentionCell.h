//
//  MyAttentionCell.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAttentionCell : UITableViewCell
@property (strong, nonatomic) UIImageView *myAttentionImageView;
@property (strong, nonatomic) UILabel *myAttentionTitleLabel;
@property (strong, nonatomic) UIButton *cancelAttentionButton;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
