//
//  ArticleVideModel.m
//  FirstProject
//
//  Created by MacBook Air on 17/11/2.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import "ArticleVideModel.h"
@interface ArticleVideModel()
//resultModel
@property(nonatomic,strong)AResultModel *resultModel;
//articleModel
@property(nonatomic,strong)ArticleModel *model;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end
@implementation ArticleVideModel


- (void)getArticlesInfoByPage:(NSInteger)page Size:(NSInteger)size andType:(NSInteger)type callBack:(void (^)(id dic,NSError *err))callBack{
    
    [self.dataArray removeAllObjects];
    [MainNetwork getArticleListFromInternetByPage:page Size:size andType:type callBackBlock:^(NSDictionary *dataDic, NSError *error) {
        if (!error) {
            //成功
            self.resultModel = [AResultModel mj_objectWithKeyValues:dataDic];
            [self.dataArray addObjectsFromArray:self.resultModel.data];
            callBack(dataDic,nil);
        }else {
            callBack(nil,error);
        }
    }];
}

//loadMoreData
- (void)loadMoreDataByPage:(NSInteger)page Size:(NSInteger)size andType:(NSInteger)type callBack:(void (^)(id, NSError *))callBack {
    [MainNetwork getArticleListFromInternetByPage:page Size:size andType:type callBackBlock:^(NSDictionary * dic, NSError *error) {
        if (!error) {
            //成功
            self.resultModel = [AResultModel mj_objectWithKeyValues:dic];
            [self.dataArray addObjectsFromArray:self.resultModel.data];
            callBack(dic,nil);
        }else {
            callBack(nil,error);
        }
    }];
}

- (NSInteger)getArticleTypeWithIndex:(NSInteger)index {
    self.model = self.dataArray[index];
    return self.model.aType;
}

- (NSInteger)getArticlesNumber {

    return self.dataArray.count;
}
//用户名
- (NSString *)getAuthorWithIndex:(NSInteger)index {
    self.model = self.dataArray[index];
    return self.model.author;
}
//大图
- (NSString *)getBigImageWithIndex:(NSInteger)index {
    self.model = self.dataArray[index];
    return self.model.imgUrl;
}
//简介
- (NSString *)getContentLabelWithIndex:(NSInteger)index {
    self.model = self.dataArray[index];
    //去掉段首段尾空格
    [self.model.desc stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //去掉段内空格
    self.model.desc = [self.model.desc stringByReplacingOccurrencesOfString:@" " withString:@""];
    return self.model.desc;
}
- (NSString *)getArticleTitleWithIndex:(NSInteger)index {
    self.model = self.dataArray[index];
    return self.model.aTitle;
}
//获取Mongold
- (NSString *)getMongoldWithIndex:(NSInteger)index {
    self.model = self.dataArray[index];
    return self.model.mongoId;
}
//获取articleId
- (NSInteger)getArticleIdWithIndex:(NSInteger)index {
    self.model = self.dataArray[index];
    return self.model.articleId;
}

#pragma mark lazy
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
- (ArticleModel *)model {
    if(!_model){
        _model = [[ArticleModel alloc]init];
    }
    return _model;
}
- (AResultModel *)resultModel {
    if (!_resultModel) {
        _resultModel = [[AResultModel alloc]init];
    }
    return _resultModel;
}
@end
