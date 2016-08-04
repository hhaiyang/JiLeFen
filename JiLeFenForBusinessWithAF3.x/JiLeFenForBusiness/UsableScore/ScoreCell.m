//
//  ScoreCell.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/6/3.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ScoreCell.h"



@implementation ScoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews {
    UIView *line = [UIView new];
    line.frame = CGRectMake(0, 0, self.width, 1.5);
    self.line = line;
    [ViewUtil drawDashLine:line lineLength:2.5 lineSpacing:1.5 lineColor:kRGBColor(241, 207, 211)];
    [self addSubview:line];
    
    UILabel *firstLabel = [UILabel new];
    self.firstLabel = firstLabel;
    [self addSubview:firstLabel];
    
    UILabel *secondLabel = [UILabel new];
    self.secondLabel = secondLabel;
    [self addSubview:secondLabel];
    
    UILabel *thirdLabel = [UILabel new];
    self.thirdLabel = thirdLabel;
    [self addSubview:thirdLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.line.frame = CGRectMake(0, self.height-1.5, self.width, 1.5);
    
    CGFloat height = (self.height-50)/2;
    self.firstLabel.frame = CGRectMake(20, 20, self.width-40, height);
    CGFloat width = self.width-50-100;
    self.secondLabel.frame = CGRectMake(20, height+30, width, height);
    self.thirdLabel.frame = CGRectMake(width+30, height+30, 100, height);
    
}
@end
