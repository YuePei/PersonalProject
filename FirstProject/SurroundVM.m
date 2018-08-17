//
//  SurroundVM.m
//  FirstProject
//
//  Created by MacBook Air on 2018/3/1.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "SurroundVM.h"
#import "SUNetwork.h"

@interface SurroundVM()
//dataArray
@property(nonatomic,copy)NSMutableArray *dataArray;
//goodsModel
@property(nonatomic,strong)GoodsDetailModel *model;

@end
@implementation SurroundVM
static int page = 2;
- (void)getGoodsListWithType:(NSInteger)type CallBack:(void (^)(NSError *error))callBack {
    if (type == 1) {
        //刷新
        [SUNetwork getGoodslistWithPageNumber:1 CallBack:^(id obj, NSError *error) {
            if (!error) {
                [self.dataArray removeAllObjects];
                GoodsModel *goodsModel = [[GoodsModel alloc]init];
                goodsModel = [GoodsModel mj_objectWithKeyValues:obj];
                [self.dataArray addObjectsFromArray:goodsModel.data];
                self.model = self.dataArray[1];
            }
            callBack(error);
        }];
    }else {
        //加载更多
        [SUNetwork getGoodslistWithPageNumber:page CallBack:^(id obj, NSError *error) {
            if (!error) {
                //加载更多
                GoodsModel *goodsModel = [[GoodsModel alloc]init];
                goodsModel = [GoodsModel mj_objectWithKeyValues:obj];
                [self.dataArray addObjectsFromArray:goodsModel.data];
                self.model = self.dataArray[1];
                page ++;
            }
            callBack(error);
        }];
    }
}

//获取大图
- (NSString *)getImgAtIndexPathRow:(NSInteger)index{
    self.model = self.dataArray[index];
    return self.model.img;
}
//获取名称
- (NSString *)getNameAtIndex:(NSInteger)index{
    self.model = self.dataArray[index];
    return self.model.name;
}
//获取价格
- (NSString *)getPriceAtIndex:(NSInteger)index{
    self.model = self.dataArray[index];
    return self.model.displayPrice;
}
//获取购买数量
- (NSInteger)getSellNumberAtIndex:(NSInteger)index{
    self.model = self.dataArray[index];
    return self.model.sold;
}
- (NSInteger)getCellNumber {
    return self.dataArray.count;
}


#pragma mark lazy
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
- (GoodsDetailModel *)goodsModel {
    if(!_model) {
        _model = [GoodsDetailModel new];
    }
    return _model;
}

@end
