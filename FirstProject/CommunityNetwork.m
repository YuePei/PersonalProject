//
//  CommunityNetwork.m
//  FirstProject
//
//  Created by MacBook Air on 2018/2/23.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "CommunityNetwork.h"

@implementation CommunityNetwork
+ (void)getGifListWithApiKey:(NSString *)api_Key limit:(int)limit offSet:(int)offset CallBackBlock:(void (^)(id, NSError *))callBack {
//    [FQLHttpTools get:@"http://api.giphy.com/v1/gifs/trending" parameters:@{@"api_key":api_Key,@"limit":@(limit),@"offset":@(offset)} success:^(id obj) {
//        NSLog(@"result:   %@",obj);
//        callBack(obj,nil);
//    } failure:^(NSError *error) {
//        callBack(error,nil);
//    }];
    [FQLHttpTools get:@"http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC&limit=20&offset=0" parameters:nil success:^(id obj) {
        callBack(obj,nil);
    } failure:^(NSError *error) {
        callBack(error,nil);
    }];
}

+ (void)getMoreGifWithApiKey:(NSString *)api_Key limit:(int)limit offSet:(int)offset CallBackBlock:(void (^)(id, NSError *))callBack {
    [FQLHttpTools get:@"http://api.giphy.com/v1/gifs/trending" parameters:@{@"api_key":@"dc6zaTOxFJmzC",@"limit":@(limit),@"offset":@(offset)} success:^(id obj) {
        callBack(obj,nil);
    } failure:^(NSError *error) {
        callBack(nil,error);
    }];
}
@end
