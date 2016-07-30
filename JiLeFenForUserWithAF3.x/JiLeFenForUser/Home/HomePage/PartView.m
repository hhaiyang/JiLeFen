//
//  PartView.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/7/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "PartView.h"

@implementation PartView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@"标志"];
        [self addSubview:_imageView];
        
        _firstLabel = [UILabel new];
        NSMutableAttributedString *str = [NSMutableAttributedString new];
        NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"阳光家具  " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"6" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor redColor]}];
        NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:@"倍积分" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        [str appendAttributedString:str1];
        [str appendAttributedString:str2];
        [str appendAttributedString:str3];
        _firstLabel.attributedText = str;
        [self addSubview:_firstLabel];
        
        _secondLabel = [UILabel new];
        str = [NSMutableAttributedString new];
        str1 = [[NSAttributedString alloc] initWithString:@"全场" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor grayColor]}];
        str2 = [[NSMutableAttributedString alloc] initWithString:@"5" attributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        str3 = [[NSAttributedString alloc] initWithString:@"折" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor grayColor]}];
        [str appendAttributedString:str1];
        [str appendAttributedString:str2];
        [str appendAttributedString:str3];
        _secondLabel.attributedText = str;
        [self addSubview:_secondLabel];
        
        _thirdLabel = [UILabel new];
        _thirdLabel.textAlignment = NSTextAlignmentRight;
        str = [NSMutableAttributedString new];
        str1 = [[NSAttributedString alloc] initWithString:@"沙发特价" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor grayColor]}];
        str2 = [[NSMutableAttributedString alloc] initWithString:@"1688" attributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        str3 = [[NSAttributedString alloc] initWithString:@"元" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor grayColor]}];
        [str appendAttributedString:str1];
        [str appendAttributedString:str2];
        [str appendAttributedString:str3];
        _thirdLabel.attributedText = str;
        [self addSubview:_thirdLabel];
        
       // _pointImageView = [UIImageView new];
       // _pointImageView.image = [UIImage imageNamed:@""];
        
        
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = CGRectMake(self.width/3*2, 5, self.width/3, self.height-10);
    _firstLabel.frame = CGRectMake(0, 0, self.width-_imageView.width-10, self.height/3);
    _secondLabel.frame = CGRectMake(0, _firstLabel.height, _firstLabel.width, _firstLabel.height);
    _thirdLabel.frame = CGRectMake(0, _secondLabel.y+_secondLabel.height, _secondLabel.width, _secondLabel.height);
    
    
}


@end
