//
//  CommunityNetwork.h
//  FirstProject
//
//  Created by MacBook Air on 2018/2/23.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityNetwork : NSObject
+ (void)getGifListWithApiKey:(NSString *)api_Key limit:(int)limit offSet:(int)offset CallBackBlock:(void (^)(id dic, NSError *error))callBack;
+ (void)getMoreGifWithApiKey:(NSString *)api_Key limit:(int)limit offSet:(int)offset CallBackBlock:(void (^)(id dic, NSError *error))callBack;
@end
