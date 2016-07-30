//
//  SystemInfo.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "SystemInfo.h"
#import "UIDevice+Addition.h"

@implementation SystemInfo
+ (NSString *)deviceIdentifier
{
    return [[UIDevice currentDevice] deviceIdentifier];
}

+ (NSString *)iOSVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)appVersion
{
    NSString *versionValue = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return versionValue;
}

+ (NSString *)appIdentifier
{
    static NSString * _identifier = nil;
    if (nil == _identifier)
    {
        _identifier = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    }
    
    return _identifier;
}

+ (NSString *)osType
{
    return @"iphone";
}

@end
