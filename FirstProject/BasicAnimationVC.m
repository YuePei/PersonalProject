//
//  BasicAnimationVC.m
//  FirstProject
//
//  Created by MacBook Air on 17/11/16.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import "BasicAnimationVC.h"

@interface BasicAnimationVC ()
@property(nonatomic,strong)UIView *animationView;

@end

@implementation BasicAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark OverRide
- (void)clickButton:(UIButton *)button {
    switch (button.tag) {
        case 0:
            [self positionAnimation];
            break;
        case 1:
            [self opacityAnimation];
            break;
        case 2:
            [self scaleAnimation];
            break;
        case 3:
            [self rotationAnimation];
            break;
        case 4:
            [self transform3DAnimation];
            break;
        case 5:
            [self backgroundColorAnimation];
            break;
        default:
            break;
    }
}
- (void)initView {
    [super initView];
    [self animationView];
    
    
}

#pragma mark lazy
- (NSArray *)arr {
    return @[@"位移",@"透明度",@"缩放",@"旋转",@"3D旋转",@"背景色"];
}

- (UIView *)animationView {
    if (_animationView == nil) {
        _animationView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 -50, SCREEN_HEIGHT / 2 - 50, 100, 100)];
        [self.view addSubview:_animationView];
        _animationView.backgroundColor = [UIColor redColor];
    }
    return _animationView;
}

//位移动画
- (void)positionAnimation {
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    basicAnimation.duration = 0.5;
    basicAnimation.repeatCount = 2;
    [basicAnimation setAutoreverses:YES];
    basicAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH / 2 - 50, SCREEN_HEIGHT / 2 - 50)];
    basicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 400)];
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.removedOnCompletion = NO;
    
    [self.animationView.layer addAnimation:basicAnimation forKey:@"positionAnimation"];
}
//透明度动画
- (void)opacityAnimation {
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    basicAnimation.duration = 3;
    basicAnimation.repeatCount = 100;
    [basicAnimation setAutoreverses:YES];
    basicAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    basicAnimation.toValue = [NSNumber numberWithFloat:0.3f];
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.removedOnCompletion = NO;
    
    [self.animationView.layer addAnimation:basicAnimation forKey:@"opacityAnimation"];
}

//缩放动画
- (void)scaleAnimation {
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAnimation.duration = 1.0;
    basicAnimation.repeatCount = 100000000;
    [basicAnimation setAutoreverses:YES];
    basicAnimation.toValue = [NSNumber numberWithFloat:0.2];
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.removedOnCompletion = NO;
    
    [self.animationView.layer addAnimation:basicAnimation forKey:@"scaleAnimation"];
}

//旋转
- (void)rotationAnimation {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.duration = 0.6;
    rotationAnimation.repeatCount = 100000000;
    [rotationAnimation setAutoreverses:YES];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI];

    [self.animationView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

//3D旋转
- (void)transform3DAnimation {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotationAnimation.duration = 0.6;
    rotationAnimation.repeatCount = 100000000;
    [rotationAnimation setAutoreverses:YES];
    //3D旋转
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 0.0005;
    rotationAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(transform, M_PI, 1, -1, 0)];
    [self.animationView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


- (void)backgroundColorAnimation {
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    basicAnimation.duration = 1;
    basicAnimation.repeatCount = 100;
    [basicAnimation setAutoreverses:YES];
    basicAnimation.toValue = (id)[UIColor whiteColor].CGColor;
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.removedOnCompletion = NO;
    
    [self.animationView.layer addAnimation:basicAnimation forKey:@"backgroundColorAnimation"];
}


@end
