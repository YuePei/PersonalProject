//
//  PhotoCollectionViewCell.m
//  FirstProject
//
//  Created by MacBook Air on 2018/2/20.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell
- (instancetype)init {
    self = [super init];
    if (self) {
        [self photoIV];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self photoIV];
    }
    return self;
}

#pragma mark lazy
- (UIImageView *)photoIV {
    if (!_photoIV) {
        _photoIV = [[UIImageView alloc]init];
        [self.contentView addSubview:_photoIV];
        
        [_photoIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    
    return _photoIV;
}
@end
