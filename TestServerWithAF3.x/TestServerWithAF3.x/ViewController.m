//
//  ViewController.m
//  TestServerWithAF3.x
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
    
}

- (void)addjifen {
    //问题：mycode参数是mycode还是myCode，为什么传mycode得到的是1，传myCode得到的是0
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"userid"] = @"13051616145";
    para[@"mycode"] = @"1234";
    para[@"jifen_num"] = @"12";
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=addjifen" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"res = %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@", error);
        
    }];
}
- (void)goodslist {
    //OK
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"pagesize"] = @"10";
    para[@"pagenum"] = @"1";
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=goodslist" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"res = %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@", error);
        
    }];
    
}
- (void)userinfo {
    //ok
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"userid"] = @"13051616145";
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=userinfo" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"res = %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@", error);
        
    }];
}
- (void)jifenlist {
    //ok
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"userid"] = @"13051616145";
    para[@"pagesize"] = @"10";
    para[@"pagenum"] = @"1";
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=jifenlist" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"res = %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@", error);
        
    }];
    
}
- (void)goodsinfo {
    //有数据，返回状态码：0
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"id"] = @"123";
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=goodsinfo" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"res = %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@", error);
        
    }];
    
}
- (void)cashgoods {
    //有数据，返回状态码：0
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"id"] = @"123";
    para[@"userid"] = @"13051616145";
    para[@"name"] = @"f";
    para[@"count"] = @"2";
    para[@"prices"] = @"12";
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=cashgoods" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"res = %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@", error);
        
    }];
}
- (void)cashlist {
    //ok, status = 0
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"userid"] = @"13051616145";
    para[@"isget"] = @"-1";
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=cashlist" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"res = %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@", error);
        
    }];
    
}
- (void)getgoods {
    //ok, status = 0
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"id"] = @"123";
    para[@"mycode"] = @"12";
    para[@"goods_id"] = @"345";
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=getgoods" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"res = %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@", error);
        
    }];
    
}
- (void)getpm {
    //ok, res = null
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"userid"] = @"13051616145";
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=getpm" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"res = %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@", error);
        
    }];
    
}
- (void)login {
    
}


@end
