//
//  ArticleVideModel.h
//  FirstProject
//
//  Created by MacBook Air on 17/11/2.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleVideModel : NSObject



- (void)getArticlesInfoByPage:(NSInteger)page Size:(NSInteger)size andType:(NSInteger)type callBack:(void (^)(id dic,NSError *err))callBack;
- (void)loadMoreDataByPage:(NSInteger)page Size:(NSInteger)size andType:(NSInteger)type callBack:(void (^)(id dic,NSError *err))callBack;

//获取文章类型
- (long)getArticleTypeWithIndex:(NSInteger)index;

- (NSInteger)getArticlesNumber;

- (NSString *)getAuthorWithIndex:(NSInteger)index;

- (NSString *)getBigImageWithIndex:(NSInteger)index;
//描述
- (NSString *)getContentLabelWithIndex:(NSInteger)index;
//文章标题
- (NSString *)getArticleTitleWithIndex:(NSInteger)index;
//获取Mongold
- (NSString *)getMongoldWithIndex:(NSInteger)index;
//获取articleId
- (NSInteger)getArticleIdWithIndex:(NSInteger)index;
//获取文章类型
- (long)getArticleTypeWithIndex:(NSInteger)index;

@end
