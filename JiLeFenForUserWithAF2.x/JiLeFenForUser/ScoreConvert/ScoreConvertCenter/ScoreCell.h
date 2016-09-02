//
//  ScoreCell.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goods.h"


@interface ScoreCell : UITableViewCell
@property (nonatomic, strong) UIImageView *thumb;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *briefLabel;
@property (nonatomic, strong) TTTAttributedLabel *priceLabel;
@property (nonatomic, strong) UILabel *costLabel;
@property (nonatomic, strong) Goods *goods;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
