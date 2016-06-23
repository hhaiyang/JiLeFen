//
//  CategoryCell.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
    if (cell == nil) {
        cell = [[[UINib nibWithNibName:@"HomeCell" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        _categoryView = [UIView new];
        [self addSubview:_categoryView];
        
        _categoryLabel = [UILabel new];
        _categoryLabel.textColor = [UIColor grayColor];
        _categoryLabel.font = [UIFont systemFontOfSize:16];
        [_categoryView addSubview:_categoryLabel];
        
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setBackgroundImage:[UIImage imageNamed:@"首页-更多小图标"] forState:UIControlStateNormal];
        [_categoryView addSubview:_moreButton];
        
        _primaryRecommendView = [PrimaryRecommendView new];
        [self addSubview:_primaryRecommendView];
        
        for (int index = 0; index < 2; index++) {
            SecondaryRecommendView *secondaryRecommendView = [SecondaryRecommendView new];
            [self addSubview:secondaryRecommendView];
            if (index == 0) {
                _topSecondaryRecommendView = secondaryRecommendView;
            } else {
                _bottomSecondaryRecommendView = secondaryRecommendView;
            }
        }
        
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _categoryView.frame = CGRectMake(0, 5, self.width, 21);
    _categoryLabel.frame = CGRectMake(20, 0, 50, _categoryView.height);
    UIImage *image = [_moreButton backgroundImageForState:UIControlStateNormal];
    _moreButton.frame = CGRectMake(_categoryView.width-10-(image.size.width/image.size.height*_categoryView.height), 0, image.size.width/image.size.height*_categoryView.height, _categoryView.height);
    _primaryRecommendView.frame = CGRectMake(5, _categoryView.y+_categoryView.height+5, self.height-15-_categoryView.height, self.height-15-_categoryView.height);
    _topSecondaryRecommendView.frame = CGRectMake(_primaryRecommendView.x*2+_primaryRecommendView.width, _primaryRecommendView.y, self.width-3*_primaryRecommendView.x-_primaryRecommendView.width, (self.height-20-_categoryView.height)/2);
    _bottomSecondaryRecommendView.frame = CGRectMake(_topSecondaryRecommendView.x, _topSecondaryRecommendView.y+_topSecondaryRecommendView.height+5, _topSecondaryRecommendView.width, _topSecondaryRecommendView.height);
}
@end
