//
//  GoodsCell.h
//  FirstProject
//
//  Created by MacBook Air on 2018/3/1.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsCell : UICollectionViewCell
//bigImageView
@property(nonatomic,strong)UIImageView *bigIV;
//name
@property(nonatomic,strong)UILabel *nameLabel;
//price
@property(nonatomic,strong)UILabel *priceLabel;
//sell
@property(nonatomic,strong)UILabel *sellLabel;
@end
