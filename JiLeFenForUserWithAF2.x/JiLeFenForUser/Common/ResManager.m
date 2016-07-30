//
//  ResManager.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ResManager.h"
#import "Sandbox.h"
@interface ResManager ()

@property (nonatomic, strong) NSMutableDictionary *imagePathDict;

- (void)loadImagePath;

@end

@implementation ResManager
+ (ResManager *)sharedInstance
{
    static ResManager *_resManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _resManager = [[self alloc] init];
    });
    return _resManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self loadImagePath];
    }
    
    return self;
}

- (void)loadImagePath
{
    NSString *imageConfigPath = [[Sandbox appPath] stringByAppendingPathComponent:@"/res/resconfig.plist"];
    NSMutableDictionary *tmpdic = [[NSMutableDictionary alloc] initWithContentsOfFile:imageConfigPath];
    self.imagePathDict = [tmpdic objectForKey:@"res"];
}

- (NSString *)pathForImage:(NSString *)imageName
{
    NSString *imagePath = [[Sandbox appPath] stringByAppendingPathComponent:[self.imagePathDict objectForKey:imageName]];
    return imagePath;
}

@end
