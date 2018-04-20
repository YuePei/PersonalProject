//
//  ArticleModel.h
//  FirstProject
//
//  Created by MacBook Air on 17/11/2.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import <Foundation/Foundation.h>


@class AResultModel,ArticleModel;

@interface AResultModel : NSObject
//code
@property(nonatomic,strong)NSString *code;
//data
@property(nonatomic,copy)NSArray *data;
//message
@property(nonatomic,strong)NSString *message;

@end


@interface ArticleModel : NSObject

@property(nonatomic,assign)NSInteger articleId;

@property(nonatomic,strong)NSString *mongoId;

@property(nonatomic,strong)NSString *aTitle;

@property(nonatomic,strong)NSString *author;

@property(nonatomic,strong)NSString *imgUrl;

@property(nonatomic,strong)NSString *desc;

@property(nonatomic,strong)NSString *publishTs;

@property(nonatomic,strong)NSString *readNum;

@property(nonatomic,strong)NSString *praiseNum;

@property(nonatomic,strong)NSString *commentNum;

@property(nonatomic,strong)NSString *hasRead;

@property(nonatomic,strong)NSString *enArticle;

@property(nonatomic,assign)NSInteger aType;

@end





