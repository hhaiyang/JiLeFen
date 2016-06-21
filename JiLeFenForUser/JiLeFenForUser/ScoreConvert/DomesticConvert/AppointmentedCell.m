//
//  AppointmentedCell.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/6/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AppointmentedCell.h"

@implementation AppointmentedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
@end
