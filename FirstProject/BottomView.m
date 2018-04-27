//
//  BottomView.m
//  FirstProject
//
//  Created by Peyton on 2018/4/27.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "BottomView.h"

@implementation BottomView

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
    }
    [_collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
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
    }
    [_commentBtn setTitle:@"评论" forState:UIControlStateNormal];
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
    }
    [_likeBtn setBackgroundColor:[UIColor purpleColor]];
    [_likeBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [self setButtonStyle:_likeBtn];
    [_likeBtn setImage:[UIImage imageNamed:@"其它"] forState:UIControlStateNormal];
    [_likeBtn setTitle:@"喜欢" forState:UIControlStateNormal];
    
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
    }
    [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    return _shareBtn;
}
//必须重写
- (void)drawRect:(CGRect)rect {
    [self collectBtn];
    [self commentBtn];
    [self likeBtn];
    [self shareBtn];
}

-(void)setButtonStyle:(UIButton*)btn{
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-15, btn.frame.size.width / 2.0 - btn.imageView.frame.origin.x - btn.imageView.frame.size.width / 2.0,0,0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.frame.size.height / 2.0,-(btn.titleLabel.frame.origin.x + btn.titleLabel.frame.size.width / 2.0 - btn.frame.size.width / 2.0), 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    
}



@end
