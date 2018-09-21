
//
//  DetailCollectionViewCell.m
//  FirstProject
//
//  Created by Peyton on 2018/4/25.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "DetailCollectionViewCell.h"

@implementation DetailCollectionViewCell
- (instancetype)init {
    if (self = [super init]) {
        [self mainIV];
        [self titleLabel];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self mainIV];
        [self titleLabel];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self mainIV];
    }
    return self;
}

- (UIImageView *)mainIV {
    if (!_mainIV) {
        _mainIV = [[UIImageView alloc]init];
        [self.contentView addSubview:_mainIV];
        [_mainIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(_mainIV.mas_width);
        }];
        SetViewRadius(_mainIV, 5);
        
    }
    return _mainIV;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [self addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mainIV.mas_bottom).mas_offset(15);
            make.left.right.mas_equalTo(0);
        }];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _titleLabel;
}
@end
