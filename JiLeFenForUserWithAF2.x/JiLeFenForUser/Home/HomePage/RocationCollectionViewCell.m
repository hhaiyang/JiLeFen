//
//  RocationCollectionViewCell.m
//  优购淮北
//
//  Created by 李峰峰 on 15/8/17.
//  Copyright (c) 2015年 李峰峰. All rights reserved.
//

#import "RocationCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface RocationCollectionViewCell()

@property (strong, nonatomic) IBOutlet UIImageView *titleImage;


@end

@implementation RocationCollectionViewCell

//重写_rocationimage的setter方法
-(void)setRocationimage:(RocationImage *)rocationimage{

//    if (rocationimage.imageName != nil) {
//        NSURL *url = [NSURL URLWithString:rocationimage.imageName];
//        [self.titleImage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"02"]];
//    }else{
//        self.titleImage.image = [UIImage imageNamed:@"01"];
//    }
    NSURL *url = [NSURL URLWithString:rocationimage.imageName];
    [self.titleImage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"02"]];
}




@end
