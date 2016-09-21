//
//  CategoryCell.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrimaryRecommendView.h"
#import "SecondaryRecommendView.h"

@interface HomeCell : UITableViewCell
@property (nonatomic, strong) UIView *categoryView;
@property (nonatomic, strong) UILabel *categoryLabel;
@property (strong, nonatomic) UIButton *moreButton;
@property (nonatomic, strong) PrimaryRecommendView *primaryRecommendView;
@property (nonatomic, strong) SecondaryRecommendView *topSecondaryRecommendView;
@property (nonatomic, strong) SecondaryRecommendView *bottomSecondaryRecommendView;
@property (nonatomic, strong) NSArray *activities;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end