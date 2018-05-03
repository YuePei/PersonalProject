//
//  BottomView.m
//  FirstProject
//
//  Created by Peyton on 2018/4/27.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "BottomView.h"

@implementation BottomView

//必须重写
- (void)drawRect:(CGRect)rect {
    [self collectBtn];
    [self commentBtn];
    [self likeBtn];
    [self shareBtn];
}

#pragma mark lazy
- (UIButton *)collectBtn {
    if (!_collectBtn) {
        _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_collectBtn];
        [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH / 4.0);
        }];
        [_collectBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [_collectBtn setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
        [_collectBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [self setButtonStyle:_collectBtn];
    }
    return _collectBtn;
}

- (UIButton *)commentBtn {
    if (!_commentBtn) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_commentBtn];
        [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.collectBtn.mas_right);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH / 4.0);
        }];
        [_commentBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_commentBtn setImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
        [_commentBtn setTitle:@"评论" forState:UIControlStateNormal];
        [_commentBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [self setButtonStyle:_commentBtn];
    }
    return _commentBtn;
}

- (UIButton *)likeBtn {
    if (!_likeBtn) {
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_likeBtn];
        [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.commentBtn.mas_right);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH / 4.0);
        }];
        [_likeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_likeBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [_likeBtn setImage:[UIImage imageNamed:@"喜欢"] forState:UIControlStateNormal];
        [_likeBtn setTitle:@"喜欢" forState:UIControlStateNormal];
        [self setButtonStyle:_likeBtn];
    }
    return _likeBtn;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_shareBtn];
        [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.likeBtn.mas_right);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH / 4.0);
        }];
        [_shareBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
        [_shareBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [self setButtonStyle:_shareBtn];
    }
    return _shareBtn;
}

#pragma mark toolMethods
-(void)setButtonStyle:(UIButton*)btn{
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    //图片 向右移动的距离是标题宽度的一半,向上移动的距离是图片高度的一半
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-imageSize.height/2, titleSize.width/2, imageSize.height/2, -titleSize.width/2)];
    //标题 向左移动的距离是图片宽度的一半,向下移动的距离是标题高度的一半
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(titleSize.height/2 + 10, -imageSize.width/2, -titleSize.height/2, imageSize.width/2)];
    
}

- (void)likeFunction {
    if ([self.likeBtn.imageView.image isEqual: [UIImage imageNamed:@"喜欢"]]) {
        [_likeBtn setImage:[UIImage imageNamed:@"喜欢1"] forState:UIControlStateNormal];
    }else {
        [_likeBtn setImage:[UIImage imageNamed:@"喜欢"] forState:UIControlStateNormal];
    }
}

- (void)collectFunction {
    if ([self.collectBtn.imageView.image isEqual: [UIImage imageNamed:@"收藏"]]) {
        [self.collectBtn setImage:[UIImage imageNamed:@"收藏1"] forState:UIControlStateNormal];
    }else {
        [self.collectBtn setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
    }
}
@end
