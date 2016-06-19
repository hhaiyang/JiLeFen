//
//  MyAttentionCell.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyAttentionCell.h"

@implementation MyAttentionCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _myAttentionImageView = [UIImageView new];
        _myAttentionImageView.image = [UIImage imageNamed:@"标志"];
        [self addSubview:_myAttentionImageView];
        
        _myAttentionTitleLabel = [UILabel new];
        _myAttentionTitleLabel.text = @"金鹰国际购物中心";
        [self addSubview:_myAttentionTitleLabel];
        
        _cancelAttentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_cancelAttentionButton];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _myAttentionImageView.frame = CGRectMake(5, 15, self.height-30, self.height-30);
    _myAttentionImageView.layer.cornerRadius = _myAttentionImageView.width/2;
    _myAttentionImageView.layer.masksToBounds = YES;
    
    UIImage *image = [UIImage imageNamed:@"取消关注按钮"];
    CGFloat height = 50;
    CGFloat width = image.size.width/image.size.height*height;
    [_cancelAttentionButton setBackgroundImage:image forState:UIControlStateNormal];
    _cancelAttentionButton.frame = CGRectMake(self.width-width-5, (self.height-height)/2, width, height);
    
    _myAttentionTitleLabel.frame = CGRectMake(_myAttentionImageView.x+_myAttentionImageView.width+5, 10, self.width-20-_myAttentionImageView.width-_cancelAttentionButton.width, self.height-20);
    
    
}
@end
