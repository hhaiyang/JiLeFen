//
//  UIDevice+Addition.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "UIDevice+Addition.h"
#import "SystemInfo.h"
#import <AdSupport/AdSupport.h>
#import "OpenUDID.h"
@implementation UIDevice (Addition)
- (NSString *)deviceIdentifier
{
    NSString *identify =nil;
    if (IOS6_OR_LATER)
    {
        identify= [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    else
    {
        identify = [OpenUDID value];
    }
    
    return identify;
}


@end
