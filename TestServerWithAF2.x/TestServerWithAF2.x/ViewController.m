//
//  ViewController.m
//  TestServerWithAF2.x
//
//  Created by huanghaiyang on 16/7/30.
//  Copyright © 2016年 huanghaiyang. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self firstcategory];
    [self childcategory];
    
}
- (void)firstcategory {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager POST:@"http://www.ugohb.com/app/app.php?j=user&type=firstcategory" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"res = %@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@", error);
        
    }];
}
- (void)childcategory {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"parentid"] = @"abc";
    [manager POST:@"http://www.ugohb.com/app/app.php?j=user&type=childcategory" parameters:para success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"res = %@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@", error);
        
    }];
    
}



@end
