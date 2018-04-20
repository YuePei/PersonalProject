
//
//  AdversementView.m
//  FirstProject
//
//  Created by 乐培培 on 2018/3/16.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "AdversementView.h"

@interface AdversementView ()
//广告view
@property (nonatomic , strong) UIImageView *adView;
//倒计时
@property (nonatomic , strong) UIButton *countButton;
//计时
@property (nonatomic , strong) NSTimer *countTimer;
//count
@property (nonatomic , assign) int count;

@end


static int const showTime = 5;

@implementation AdversementView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self adView];
        [self countButton];
        [self count];
        [self countTimer];
    }
    
    
    return self;
}
#pragma mark methods
//1.展示广告
- (void)showAdvertisement {
    [self startCount];
    NSLog(@"------------------------");
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}
//2.开始计时
- (void)startCount {
    self.count = showTime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
    
}
//跳过广告
- (void)skipAdvertisement {
    //停掉定时器
    [self.countTimer invalidate];
    self.countTimer = nil;
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//3.倒计时
- (void)countDown {
    self.count--;
    [_countButton setTitle:[NSString stringWithFormat:@"跳过%d",self.count] forState:UIControlStateNormal];
    if (self.count == 0) {
        [self skipAdvertisement];
    }
}
#pragma mark lazy
- (NSTimer *)countTimer {
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

- (UIImageView *)adView {
    if (!_adView) {
        _adView = [[UIImageView alloc]init];
        [self addSubview:_adView];
        [_adView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    _adView.image = [UIImage imageNamed:@"fitness"];
    return _adView;
}
- (UIButton *)countButton {
    if (!_countButton) {
        _countButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self insertSubview:_countButton aboveSubview:self.adView];
        [_countButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
            make.top.mas_equalTo(30);
            make.right.mas_equalTo(-20);
        }];
        [_countButton addTarget:self action:@selector(skipAdvertisement) forControlEvents:UIControlEventTouchUpInside];
        [_countButton setTitle:[NSString stringWithFormat:@"跳过%d",showTime] forState:UIControlStateNormal];
        _countButton.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
        [_countButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //设置圆角
//        _countButton.layer.masksToBounds = YES;
        _countButton.layer.cornerRadius = 4;
    }
    return _countButton;
}
@end
