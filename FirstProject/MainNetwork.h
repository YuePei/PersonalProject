//
//  MainNetwork.h
//  FirstProject
//
//  Created by MacBook Air on 2017/12/14.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainNetwork : NSObject

+ (void)getArticleListFromInternetByPage:(NSInteger)page Size:(NSInteger)size andType:(NSInteger)type callBackBlock:(void (^)(id dic,NSError *error))callBackBlock;
+ (void)getArticleDetailInfoByMongold:(NSString *)mongold articleId:(NSInteger )articleId andType:(NSInteger)type callBack:(void (^)(id dic,NSError *error))callBock;

@end
