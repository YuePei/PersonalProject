//
//  FQLHttpTools.m
//  FirstProject
//
//  Created by MacBook Air on 17/10/27.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import "FQLHttpTools.h"
#import <math.h>
@interface FQLHttpTools()

@end

@implementation FQLHttpTools

+ (void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(successBlock)successInfo failure:(void (^)(NSError *))failure {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //解析成json
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //回调
        successInfo(dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failure(error);
    }];
}

- (void)valueProgress {
    
}

+ (void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(successBlock)successInfo failure:(void (^)(NSError *))failure {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        successInfo(dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    
}


+ (void)customGet:(NSString *)urlString succeed:(successBlock)success failed:(void (^)(NSError *error))failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            success(dic);
        }else {
            failure(error);
        }
    }];
    [task resume];
}
@end
