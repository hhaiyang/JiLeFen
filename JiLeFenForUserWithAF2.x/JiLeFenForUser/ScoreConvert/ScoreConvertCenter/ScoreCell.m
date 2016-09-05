//
//  ScoreCell.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ScoreCell.h"
#import "UIImageView+WebCache.h"

@interface ScoreCell ()
@property (nonatomic, strong) UIView *line;
@end

@implementation ScoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //图片
        _thumb = [UIImageView new];
        [self addSubview:_thumb];
        
        //标题
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_nameLabel];
        
        //简介
        _briefLabel = [UILabel new];
        _briefLabel.font = [UIFont systemFontOfSize:11];
        _briefLabel.textColor = [UIColor grayColor];
        [self addSubview:_briefLabel];
        
        //价格
        _priceLabel = [UILabel new];
        _priceLabel.font = [UIFont systemFontOfSize:11];
        _priceLabel.textColor = [UIColor grayColor];
        [self addSubview:_priceLabel];
        
        //价格上的横线
        _line = [UIView new];
        _line.backgroundColor = [UIColor grayColor];
        [_priceLabel addSubview:_line];
        
        //花费积分
        _costLabel = [UILabel new];
        _costLabel.font = [UIFont systemFontOfSize:16];
        _costLabel.textColor = kRGBColor(231, 74, 93);
        [self addSubview:_costLabel];
        
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thumb.frame = CGRectMake(5, 5, self.height-10, self.height-10);
    _nameLabel.frame = CGRectMake(_thumb.x+_thumb.width+5, 5, self.width-15-_thumb.width, (self.height-10)/4);
    _briefLabel.frame = CGRectMake(_nameLabel.x, _nameLabel.y+_nameLabel.height, _nameLabel.width, _nameLabel.height);
    CGRect frame = [_priceLabel textRectForBounds:CGRectMake(0, 0, _nameLabel.width, _nameLabel.height) limitedToNumberOfLines:1];
    _priceLabel.frame = CGRectMake(_nameLabel.x, _briefLabel.y+_briefLabel.height, frame.size.width, _nameLabel.height);
    _line.frame = CGRectMake(0, (_priceLabel.height-1.5)/2, _priceLabel.width, 1.5);
    _costLabel.frame = CGRectMake(_nameLabel.x, _priceLabel.y+_priceLabel.height, _nameLabel.width, _nameLabel.height);
    
}
- (void)setGoods:(Goods *)goods {
    _goods = goods;
    [_thumb sd_setImageWithURL:[NSURL URLWithString:goods.thumb]];
    _nameLabel.text = goods.title;
    _briefLabel.text = goods.brief;
    _priceLabel.text = goods.price;
    _costLabel.text = [NSString stringWithFormat:@"%@积分", goods.cost];
}
@end
