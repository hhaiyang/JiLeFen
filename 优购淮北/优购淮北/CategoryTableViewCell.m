//
//  CategoryTableViewCell.m
//  优购淮北
//
//  Created by 李峰峰 on 15/8/21.
//  Copyright (c) 2015年 李峰峰. All rights reserved.
//

#import "CategoryTableViewCell.h"

@interface CategoryTableViewCell()

@property (strong, nonatomic) IBOutlet UIImageView *leftImage;

@property (strong, nonatomic) IBOutlet UILabel *rightLabel;


@end

@implementation CategoryTableViewCell


-(void)setImageName:(NSString *)imageName{
    self.leftImage.image = [UIImage imageNamed:imageName];
}

-(void)setRightLabelText:(NSString *)rightLabelText{
    self.rightLabel.text = rightLabelText;
}



@end
