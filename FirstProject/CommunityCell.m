//
//  CommunityCell.m
//  FirstProject
//
//  Created by MacBook Air on 2018/2/12.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "CommunityCell.h"
@interface CommunityCell()
//分割线
@property (nonatomic , strong) UIView *separatorLine;

@end
@implementation CommunityCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self bottomIV];
        [self gradientLayer];
        [self titleL];
        [self authorIV];
        [self authorname];
        [self abstractLabel];
        [self separatorLine];
    }
    return self;
}
- (UIImageView *)bottomIV {
    if (!_bottomIV) {
        _bottomIV = [[UIImageView alloc]init];
        [self.contentView addSubview:_bottomIV];
        [_bottomIV makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(self.bottomIV.mas_width).multipliedBy(1 / 2.0);
        }];
    }
    
    _bottomIV.layer.masksToBounds = YES;
    _bottomIV.layer.cornerRadius = 5;
    return _bottomIV;
}

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [[CAGradientLayer alloc]init];
    }
    _gradientLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor, (__bridge id)[UIColor clearColor].CGColor];
    _gradientLayer.locations = @[@0, @0.32];
    _gradientLayer.startPoint = CGPointMake(0, 1.0);
    _gradientLayer.endPoint = CGPointMake(0, 0);
    _gradientLayer.opacity = 0.45;
    [self.bottomIV.layer insertSublayer:_gradientLayer below:self.titleL.layer];
    _gradientLayer.frame = CGRectMake(0, 0, self.contentView.frame.size.width - 20, (self.contentView.frame.size.width - 20) / 2.0);
    
    return _gradientLayer;
}

- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [[UILabel alloc]init];
    }
    [self.bottomIV addSubview:_titleL];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo (-10);
        make.bottom.mas_equalTo(-8);
    }];
    _titleL.numberOfLines = 2;
    _titleL.font = [UIFont systemFontOfSize:18];
    _titleL.textColor = [UIColor whiteColor];
    return _titleL;
}

- (UIImageView *)authorIV {
    if (!_authorIV) {
        _authorIV = [[UIImageView alloc]init];
        [self.contentView addSubview:_authorIV];
        [_authorIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.bottomIV.mas_bottom).mas_offset(12);
            if (SCREEN_WIDTH > 414) {
                make.width.height.mas_equalTo(70);
            }else {
                make.width.height.mas_equalTo(40);
            }
            
        }];
        _authorIV.layer.masksToBounds = YES;
        if (SCREEN_WIDTH > 414) {
            _authorIV.layer.cornerRadius = 35;
        }else {
            _authorIV.layer.cornerRadius = 20;
        }
        
    }
    return _authorIV;
}
- (UILabel *)authorname {
    if (!_authorname) {
        _authorname = [[UILabel alloc]init];
        [self.contentView addSubview:_authorname];
        [_authorname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.authorIV.mas_top).mas_offset(1);
            make.left.mas_equalTo(self.authorIV.mas_right).mas_offset(10);
            make.width.mas_offset(SCREEN_WIDTH - 32- 46);
        }];
        if(SCREEN_WIDTH > 414.0) {
            _authorname.font = [UIFont boldSystemFontOfSize:22];
        }else {
            _authorname.font = [UIFont boldSystemFontOfSize:14];
        }
        _authorname.text = @"家与自由，从来不是对立的事物，所有的束缚都来自内心的不平静。";
    }
    return _authorname;
}
- (UILabel *)abstractLabel {
    if (!_abstractLabel) {
        _abstractLabel = [UILabel new];
        [self.contentView addSubview:_abstractLabel];
        [_abstractLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.authorname.mas_left);
            make.bottom.mas_equalTo(self.authorIV.mas_bottom).mas_offset(-2);
        }];
        _abstractLabel.textColor = [UIColor darkGrayColor];
        if (SCREEN_WIDTH > 414.0) {
            _abstractLabel.font = [UIFont systemFontOfSize:19];
        }else {
            _abstractLabel.font = [UIFont systemFontOfSize:14];
        }
        _abstractLabel.text = @"Here's the abstract words.";
    }
    return _abstractLabel;
}
- (UIView *)separatorLine {
    if (!_separatorLine) {
        _separatorLine = [UIView new];
        [self.contentView addSubview:_separatorLine];
        [_separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.left.mas_equalTo(self.bottomIV.mas_left);
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(self.bottomIV.mas_right);
        }];
        _separatorLine.backgroundColor = BackgroundColor;
    }
    return _separatorLine;
}
@end
