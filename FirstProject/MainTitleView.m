//
//  MainTitleView.m
//  FirstProject
//
//  Created by Peyton on 2018/9/21.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "MainTitleView.h"

@implementation MainTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self recommendButton];
        [self allButton];
        [self indicatorView];
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(100, 40);
}

#pragma mark clickMethod
- (void)clickButton:(id)sender {
    UIButton *selectButton = sender;
    [self.indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(selectButton.mas_left);
        make.right.mas_equalTo(selectButton.mas_right);
        make.height.mas_equalTo(3);
        make.top.mas_equalTo(self.mas_bottom).offset(-3);
    }];
    [UIView animateWithDuration:0.2f animations:^{
        [self layoutIfNeeded];
    }];
}

#pragma mark lazy
//推荐
- (UIButton *)recommendButton {
    if (!_recommendButton) {
        _recommendButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_recommendButton];
        [_recommendButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.centerY).mas_offset(5);
            make.left.mas_equalTo(0);
        }];
        [_recommendButton setTitleColor:blackMainColor forState:UIControlStateNormal];
        _recommendButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_recommendButton setTitle:@"推 荐" forState:UIControlStateNormal];
        
        [_recommendButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _recommendButton;
}

//所有
- (UIButton *)allButton {
    if (!_allButton) {
        _allButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_allButton];
        [_allButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.centerY).mas_offset(5);
            make.right.mas_equalTo(0);
        }];
        [_allButton setTitleColor:blackMainColor forState:UIControlStateNormal];
        _allButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_allButton setTitle:@"全 部" forState:UIControlStateNormal];
        
        [_allButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allButton;
}

//横线
- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [UIView new];
        [self addSubview:_indicatorView];
        [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.recommendButton.mas_left);
            make.right.mas_equalTo(self.recommendButton.mas_right);
            make.top.mas_equalTo(self.mas_bottom).offset(-3);
            make.height.mas_equalTo(3);
        }];
    }
    _indicatorView.backgroundColor = blackMainColor;
    return _indicatorView;
}
@end
