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

#pragma mark clickMethod
- (void)didClickRecommendButton {
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.recommendButton.mas_left);
    }];
    [UIView animateWithDuration:0.3f animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)didClickAllButton {
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.allButton.mas_left);
    }];
    [UIView animateWithDuration:0.3f animations:^{
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
        _recommendButton.titleLabel.textColor = blackMainColor;
        _recommendButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_recommendButton setTitle:@"推 荐" forState:UIControlStateNormal];
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
        _allButton.titleLabel.textColor = blackMainColor;
        _allButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_allButton setTitle:@"全 部" forState:UIControlStateNormal];
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
            make.width.mas_equalTo(self.recommendButton.mas_width);
            make.top.mas_equalTo(self.mas_bottom).offset(-2);
            make.height.mas_equalTo(2);
        }];
    }
    _indicatorView.backgroundColor = blackMainColor;
    return _indicatorView;
}
@end
