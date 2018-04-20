//
//  ArticleDetailModel.h
//  FirstProject
//
//  Created by 乐培培 on 2018/3/15.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ArticleDataModel,ArticleDetailModel;


@interface ArticleDetailModel : NSObject
//data
@property (nonatomic , strong) ArticleDataModel *data;
//message
@property (nonatomic , copy) NSString *message;

@end




@interface ArticleDataModel : NSObject
//articleId
@property (nonatomic , assign) NSInteger articleId;
//author
@property (nonatomic , copy) NSArray *author;
//authorDescription
@property (nonatomic , copy) NSString *authorDescription;
//authorId
@property (nonatomic , copy) NSString *authorId;
//authorTopic
@property (nonatomic , copy) NSString *authorTopic;
//collectCount
@property (nonatomic , assign) NSInteger collectCount;
//commentCount
@property (nonatomic , assign) NSInteger commentCount;
//content
@property (nonatomic , copy) NSString *htmlContent;
//link
@property (nonatomic , copy) NSString *originalLink;
//原作平台
@property (nonatomic , copy) NSString *site;




@end
