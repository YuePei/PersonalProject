//
//  SDetailVc.h
//  FirstProject
//
//  Created by 乐培培 on 2018/3/12.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDetailVc : UIViewController
//大图链接
@property (nonatomic, strong)NSString *imageString;

//商品大图
@property (strong, nonatomic) UIImageView *bigImageView;
//商品名称
@property (strong, nonatomic) NSString *goodsNameString;
//商品价格
@property (strong, nonatomic) UILabel *priceLabel;
//商品原价
@property (strong, nonatomic) UILabel *oldPriceLabel;
//商品标记
@property (strong, nonatomic) UIImageView *tagImageView;
//销量
@property (strong, nonatomic) UILabel *soldCount;
@end
