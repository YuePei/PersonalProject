//
//  ComprehensiveAnimationVC.m
//  FirstProject
//
//  Created by MacBook Air on 17/11/21.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import "ComprehensiveAnimationVC.h"

@interface ComprehensiveAnimationVC ()

@property(nonatomic,strong)UIView *circleView;

@property(nonatomic,strong)NSMutableArray<UIButton *> *buttonsArr;

@end

@implementation ComprehensiveAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



#pragma mark 重写父类的方法
- (NSArray *)arr {
    return @[@"叮叮"];
}

- (void)clickButton:(UIButton *)button {
    switch (button.tag) {
        case 0:
            
            break;
        case 1:
            
            break;
            
        default:
            break;
    }
}

- (void)initView {
    [super initView];
    [self circleView];
    
    for (int i = 0; i < 6; i ++) {
        int index = 6 - i;
    }
}

- (void)tapGestureTest:(UITapGestureRecognizer *)gestureRecognizer {
    NSLog(@"------------tap--------------");
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"begin");
            break;
        case UIGestureRecognizerStateFailed:
            NSLog(@"failed");
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"ended");
            break;
        case UIGestureRecognizerStatePossible:
            NSLog(@"posible");
            break;
        case UIGestureRecognizerStateChanged:
            NSLog(@"changed");
            break;
        case UIGestureRecognizerStateCancelled:
            NSLog(@"cancled");
            break;
        default:
            break;
    }
}
#pragma mark lazy
- (UIView *)circleView {
    if (!_circleView) {
        _circleView = [[UIView alloc]init];
        [self.view addSubview:_circleView];
        [_circleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.bottom.mas_equalTo(-100);
            make.width.height.mas_equalTo(40);
        }];
        _circleView.backgroundColor = [UIColor grayColor];
        _circleView.layer.masksToBounds = YES;
        _circleView.layer.cornerRadius = 40;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureTest:)];
        [_circleView addGestureRecognizer:tapGesture];
    }
    return _circleView;
}

//- (NSMutableArray<UIButton *> *)buttonsArr {
//    if (!_buttonsArr) {
//        _buttonsArr = [NSMutableArray<UIButton *> array];
//        NSArray *titlesArr = @[@"A",@"B",@"C",@"D",@"E",@"F"];
//        for (int i = 0; i < titlesArr.count; i ++) {
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn.frame = CGRectMake(-25, -105, 30, 30);
//
//
//
//        }
//    }
//}

@end
