//
//  CommunityCell.h
//  FirstProject
//
//  Created by MacBook Air on 2018/2/12.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityCell : UICollectionViewCell
//bottomView
@property(nonatomic,strong)CAGradientLayer *gradientLayer;
//bottomIV
@property(nonatomic,strong)UIImageView *bottomIV;
//titleLabel
@property(nonatomic,strong)UILabel *titleL;
//头像
@property (nonatomic , strong) UIImageView *authorIV;
//用户名
@property (nonatomic , strong) UILabel *authorname;
//简介
@property (nonatomic , strong) UILabel *abstractLabel;

@end
