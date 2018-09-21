//
//  BottomBuyView.m
//  FirstProject
//
//  Created by Peyton on 2018/8/23.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "BottomBuyView.h"

@implementation BottomBuyView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = blackMainColor;
        [self buyButton];
        [self addButton];
        [self connectUs];
    }
    return self;
}


#pragma mark lazy
- (UIButton *)buyButton {
    if (!_buyButton) {
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_buyButton];
        [_buyButton setBackgroundColor:[UIColor blackColor]];
        [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.width.mas_equalTo(80);
            make.centerY.mas_equalTo(self.centerY);
        }];
        [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        
        _buyButton.titleLabel.font = [UIFont systemFontOfSize:13];
        //圆角
        [_buyButton.superview layoutIfNeeded];
        CAShapeLayer *layer = [CAShapeLayer layer];
        [layer setFrame:_buyButton.bounds];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:layer.bounds cornerRadius:20];
        layer.path = path.CGPath;
        _buyButton.layer.mask = layer;
    }
    return _buyButton;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_addButton];
        [_addButton setBackgroundColor:[UIColor blackColor]];
        [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.centerY);
            make.width.mas_equalTo(94);
            make.right.mas_equalTo(self.buyButton.mas_left).offset(-20);
        }];
        [_addButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        _addButton.titleLabel.font = [UIFont systemFontOfSize:13];
        //圆角
        [_addButton.superview layoutIfNeeded];
        CAShapeLayer *layer = [CAShapeLayer layer];
        [layer setFrame:_addButton.bounds];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:layer.bounds cornerRadius:20];
        layer.path = path.CGPath;
        _addButton.layer.mask = layer;
    }
    return _addButton;
}

- (UIButton *)connectUs {
    if (!_connectUs) {
        _connectUs = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_connectUs];
        [_connectUs mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(self.centerY);
            make.width.mas_equalTo(40);
        }];
        [_connectUs setBackgroundColor:[UIColor blackColor]];
        [_connectUs setTitle:@"客服" forState:UIControlStateNormal];
        _connectUs.titleLabel.font = [UIFont systemFontOfSize:13];
        //圆角
        [_connectUs.superview layoutIfNeeded];
        CAShapeLayer *layer = [CAShapeLayer layer];
        [layer setFrame:_connectUs.bounds];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:layer.bounds cornerRadius:10];
        layer.path = path.CGPath;
        _connectUs.layer.mask = layer;
    }
    return _connectUs;
}
@end
