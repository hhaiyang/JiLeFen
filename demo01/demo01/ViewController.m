//
//  ViewController.m
//  demo01
//
//  Created by huanghaiyang on 16/7/26.
//  Copyright © 2016年 huanghaiyang. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"phone"] = @"13051616145";
    [manager POST:@"http://www.ugohb.com/app/sms.php" parameters:para constructingBodyWithBlock:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"res = %@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@", error);
        
    }];
   
    
}


@end
