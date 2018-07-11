//
//  CommentView.m
//  FirstProject
//
//  Created by Peyton on 2018/5/3.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "CommentView.h"

@implementation CommentView

- (void)drawRect:(CGRect)rect {
    [self contentTextView];
    [self submitButton];
    [self atButton];
    [self expressionButton];
}

#pragma mark lazy
- (UITextView *)contentTextView {
    if (!_contentTextView) {
//        _contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, self.frame.size.height - 15 - 15 - self.submitButton.frame.size.height - 10)];
        _contentTextView = [[UITextView alloc]init];
        [self addSubview:_contentTextView];
        [_contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12 * SCREEN_PROPORTION);
            make.right.mas_equalTo(-12  * SCREEN_PROPORTION);
            make.top.mas_equalTo(15  * SCREEN_PROPORTION);
//            make.height.mas_equalTo(50);
        }];
        _contentTextView.layer.borderColor = BACK_COLOR.CGColor;
        _contentTextView.layer.borderWidth = 1;
        _contentTextView.layer.cornerRadius = 6;
        _contentTextView.layer.masksToBounds = YES;
    }
    return _contentTextView;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_submitButton];
        [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentTextView.mas_right);
            make.top.mas_equalTo(self.contentTextView.mas_bottom).offset(10 * SCREEN_PROPORTION);
            make.width.mas_equalTo(60 * SCREEN_PROPORTION);
            make.bottom.mas_equalTo(-15 * SCREEN_PROPORTION);
        }];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitButton setTitle:@"评 论" forState:UIControlStateNormal];
        _submitButton.layer.cornerRadius = 4;
        _submitButton.layer.masksToBounds = YES;
        [_submitButton setBackgroundColor:RGBColor(34, 159, 95)];
    }
    return _submitButton;
}

- (UIButton *)atButton {
    if (!_atButton) {
        _atButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_atButton];
        [_atButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentTextView.mas_left);
            make.centerY.equalTo(self.submitButton);
            make.width.mas_equalTo(_atButton.mas_height).multipliedBy(1);
        }];
        [_atButton setImage:[UIImage imageNamed:@"at"] forState:UIControlStateNormal];
    }
    return _atButton;
}

- (UIButton *)expressionButton {
    if (!_expressionButton) {
        _expressionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_expressionButton];
        [_expressionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.atButton.mas_right).offset(15);
            make.centerY.mas_equalTo(self.submitButton.centerY);
            make.width.mas_equalTo(_expressionButton.mas_height).multipliedBy(1);
            make.width.mas_equalTo(33);
        }];
        [_expressionButton setImage:[UIImage imageNamed:@"exp"] forState:UIControlStateNormal];
    }
    return _expressionButton;
}
@end
