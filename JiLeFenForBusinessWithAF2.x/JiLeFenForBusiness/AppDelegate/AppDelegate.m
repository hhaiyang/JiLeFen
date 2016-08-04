//
//  AppDelegate.m
//  JiLeFenForBusinessman
//
//  Created by huanghaiyang on 16/2/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeController.h"
#import "LoginController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initWindow];
    [self initGlobalUIStyle];
    return YES;
}
- (void)initWindow {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[LoginController new]];
    [self.window makeKeyAndVisible];
}
- (void)initGlobalUIStyle {
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor], NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
}
@end
