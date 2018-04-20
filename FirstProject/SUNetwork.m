//
//  SUNetwork.m
//  FirstProject
//
//  Created by MacBook Air on 2018/3/1.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "SUNetwork.h"

@implementation SUNetwork

+ (void)getGoodslistWithPageNumber:(NSInteger)page CallBack:(void (^)(id, NSError *))callBack{
    
    //http://life2.pianke.me/product?sortby=default&page=1
    [FQLHttpTools get:[NSString stringWithFormat:@"http://life2.pianke.me/product?sortby=default&page=%ld",page] parameters:nil success:^(id obj) {
        callBack(obj,nil);
    } failure:^(NSError *error) {
        callBack(nil,error);
    }];
}
@end
