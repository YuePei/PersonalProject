//
//  GifViewModel.m
//  FirstProject
//
//  Created by MacBook Air on 2018/2/23.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "GifViewModel.h"
@interface GifViewModel()
//resultModel
@property(nonatomic,strong)ResultModel *model;
//array
@property(nonatomic,copy)NSMutableArray *dataArray;

@end
@implementation GifViewModel
- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}
//刷新
- (void)getGifListWithApiKey:(NSString *)api_Key limit:(int)limit offSet:(int)offset CallBackBlock:(void (^)(id, NSError *))callBack {
    [CommunityNetwork getGifListWithApiKey:api_Key limit:limit offSet:offset CallBackBlock:^(NSDictionary * dic, NSError *error) {
        if (!error) {
            //succeed，对属性进行赋值
            NSLog(@"--------:%@",dic);
            [self.dataArray removeAllObjects];
            self.model = [ResultModel mj_objectWithKeyValues:dic];
            [self.dataArray addObjectsFromArray:self.model.dataArray];
            callBack(dic,nil);
        }else {
            //failed
            callBack(nil,error);
        }
    }];
}
//加载更多
- (void)getMoreGifWithApiKey:(NSString *)api_Key limit:(int)limit offSet:(int)offset CallBackBlock:(void (^)(id, NSError *))callBack {
    [CommunityNetwork getMoreGifWithApiKey:api_Key limit:limit offSet:offset CallBackBlock:^(id dic, NSError *error) {
        if (!error) {
            //succeed
            self.model = [ResultModel mj_objectWithKeyValues:dic];
            [self.dataArray addObjectsFromArray:self.model.dataArray];
            callBack(dic,nil);
        }else {
            //failed
            callBack(nil,error);
        }
    }];
}
- (NSString *)getUrlAtIndexPathRow:(NSInteger)row {
    GifModel *gifModel = self.dataArray[row];
    return gifModel.images.preview_gif.url;
}
- (NSInteger)getGifNumber {
    return self.dataArray.count;
}
#pragma mark lazy
- (ResultModel *)model {
    if (!_model) {
        _model = [[ResultModel alloc]init];
    }
    return _model;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
@end
