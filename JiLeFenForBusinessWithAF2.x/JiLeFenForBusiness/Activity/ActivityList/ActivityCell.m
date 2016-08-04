//
//  ActivityCell.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ActivityCell.h"
#import "UIImageView+WebCache.h"

@implementation ActivityCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews {
    UIView *activityContentView = [UIView new];
    activityContentView.layer.cornerRadius = 1;
    self.activityContentView = activityContentView;
    activityContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:activityContentView];
    
    UIImageView *activityImageView = [UIImageView new];
    activityImageView.backgroundColor = [UIColor orangeColor];
    self.activityImageView = activityImageView;
    [activityContentView addSubview:activityImageView];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor grayColor];
    self.titleLabel = titleLabel;
    [activityContentView addSubview:titleLabel];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.activityContentView.frame = CGRectMake(20, 7, self.width-40, self.height-7);
    CGFloat height = self.height-10;
    CGFloat width = height*1.2;
    self.activityImageView.frame = CGRectMake(5, 5, width, height);
    width = self.width-10-20-self.activityImageView.width;
    self.titleLabel.frame = CGRectMake(self.activityImageView.x+self.activityImageView.width+20, 5, width, 21);
    
    
}
- (void)setActivity:(Activity *)activity {
    _activity = activity;
    self.titleLabel.text = activity.title;
    [self.activityImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.ugohb.com%@", activity.img_path]]];
}
@end
