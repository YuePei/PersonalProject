//
//  GoodsCell.m
//  FirstProject
//
//  Created by MacBook Air on 2018/3/1.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "GoodsCell.h"

@implementation GoodsCell

- (instancetype)init {
    if (self = [super init]) {
        [self bigIV];
        [self nameLabel];
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self bigIV];
        [self nameLabel];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
    }
    return self;
}

#pragma mark lazy
- (UIImageView *)bigIV {
    if (!_bigIV) {
        _bigIV = [[UIImageView alloc]init];
        [self.contentView addSubview:_bigIV];
        [_bigIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo((SCREEN_WIDTH - 45) / 2.0);
        }];
        _bigIV.backgroundColor = [UIColor colorWithRed:171 / 255.0 green:68 / 255.0 blue:68 / 255.0 alpha:1];
    }
    return _bigIV;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.bigIV.mas_bottom).offset(10);
        }];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.numberOfLines = 2;
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _nameLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:12];
    }
    return _nameLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        }];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.font = [UIFont systemFontOfSize:15];
    }
    return _priceLabel;
}

- (UILabel *)sellLabel {
    if (!_sellLabel) {
        _sellLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_sellLabel];
        [_sellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.priceLabel);
            make.right.mas_equalTo(-15);
        }];
        _sellLabel.textColor =[UIColor lightGrayColor];
        _sellLabel.font = [UIFont systemFontOfSize:10];
    }
    return _sellLabel;
}
@end
