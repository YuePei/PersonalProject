//
//  FQLHttpTools.h
//  FirstProject
//
//  Created by MacBook Air on 17/10/27.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^successBlock)(NSDictionary *obj);

@interface FQLHttpTools : NSObject

+ (void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(successBlock)successInfo failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(successBlock)successInfo failure:(void (^)(NSError *error))failure;

+ (void)customGet:(NSString *)urlString succeed:(successBlock)success failed:(void (^)(NSError *error))failure;
@end
