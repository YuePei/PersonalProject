//
//  GoodsModel.h
//  FirstProject
//
//  Created by MacBook Air on 2018/3/1.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GoodsModel,GoodsDetailModel;

@interface GoodsModel : NSObject
//data
@property(nonatomic,copy)NSArray *data;
//versionCode
@property(nonatomic,strong)NSString *versionCode;
@end


@interface GoodsDetailModel : NSObject
//价格
@property(nonatomic,strong)NSString * displayPrice;
//大图
@property(nonatomic,strong)NSString *img;
//name
@property(nonatomic,strong)NSString *name;
//购买数量
@property(nonatomic,assign)NSInteger sold;

@end
