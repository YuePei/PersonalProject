//
//  SurroundVM.h
//  FirstProject
//
//  Created by MacBook Air on 2018/3/1.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SurroundVM : NSObject
- (void)getGoodsListWithType:(NSInteger)type CallBack:(void (^)(NSError *error))callBack;

//获取大图
- (NSString *)getImgAtIndexPathRow:(NSInteger)index;
//获取名称
- (NSString *)getNameAtIndex:(NSInteger)index;
//获取价格
- (NSString *)getPriceAtIndex:(NSInteger)index;
//获取购买数量
- (NSInteger)getSellNumberAtIndex:(NSInteger)index;
//获取cell的数量
- (NSInteger)getCellNumber;

@end
