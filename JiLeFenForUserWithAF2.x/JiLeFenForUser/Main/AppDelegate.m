//
//  AppDelegate.m
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self createWindow];
    return YES;
}

- (void)createWindow {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [TabBarController new];
    [self.window makeKeyAndVisible];
}
@end
