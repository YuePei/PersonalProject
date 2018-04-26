
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
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self mainIV];
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
            make.bottom.mas_equalTo(0);
        }];
        SetViewRadius(_mainIV, 5);
        _mainIV.backgroundColor = [UIColor purpleColor];
    }
    return _mainIV;
}
@end
