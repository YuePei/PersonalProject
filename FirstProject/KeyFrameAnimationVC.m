//
//  KeyFrameAnimationVC.m
//  FirstProject
//
//  Created by MacBook Air on 17/11/17.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import "KeyFrameAnimationVC.h"

@interface KeyFrameAnimationVC ()

@property(nonatomic,strong)UIView *animationView;

@end

@implementation KeyFrameAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 重写父类的方法
- (NSArray *)arr {
    return @[@"关键帧",@"路径",@"抖动"];
}

- (void)initView {
    [super initView];
    [self animationView];
    self.title = @"Keyframe";
    
}

- (void)clickButton:(UIButton *)button {
    switch (button.tag) {
        case 0:
            [self keyFrameAnimation];
            break;
        case 1:
            [self circleAnimation];
            break;
        case 2:
            [self shakeAnimation];
            break;
            
        default:
            break;
    }
}
#pragma mark Animation Methods
- (void)keyFrameAnimation {
    CAKeyframeAnimation *kfAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    kfAnimation.duration = 2.0;
    kfAnimation.repeatCount = MAXFLOAT;
    NSValue *v0 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH / 2 - 50, SCREEN_HEIGHT / 2)];
    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)];
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2 + 50)];
    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH / 2 + 50, SCREEN_HEIGHT / 2 + 50)];
    NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH / 2 +50, SCREEN_HEIGHT /2 + 100)];
    kfAnimation.values = [NSArray arrayWithObjects:v0,v1,v2,v3,v4, nil];
    
    [self.animationView.layer addAnimation:kfAnimation forKey:@"keyframeAnimation"];
}

- (void)shakeAnimation {
    CAKeyframeAnimation *kfAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    kfAnimation.duration = 0.3;
    NSValue *v0 = [NSNumber numberWithFloat:-M_PI / 4];
    NSValue *v1 = [NSNumber numberWithFloat:M_PI / 4];
    kfAnimation.values = @[v0,v1];
    kfAnimation.fillMode = kCAFillModeForwards;
    kfAnimation.removedOnCompletion = NO;
    [kfAnimation setAutoreverses:YES];
    kfAnimation.repeatCount = MAXFLOAT;
    [self.animationView.layer addAnimation:kfAnimation forKey:@"shakeAnimation"];
}

- (void)circleAnimation {
    CAKeyframeAnimation *kfAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 200, 200, 200)];
    kfAnimation.path = bezierPath.CGPath;
    kfAnimation.duration = 2;
    kfAnimation.repeatCount = MAXFLOAT;
    kfAnimation.fillMode = kCAFillModeForwards;
    kfAnimation.removedOnCompletion = NO;
    
    [self.animationView.layer addAnimation:kfAnimation forKey:@"bezierPathAnimation"];
}
- (void)tapBack {

//    SWRevealViewController *revealVC = self.revealViewController;
//    [revealVC popoverPresentationController];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark lazy
- (UIView *)animationView {
    if (_animationView == nil) {
        _animationView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 -25, SCREEN_HEIGHT / 2 - 25, 50, 50)];
        [self.view addSubview:_animationView];
        _animationView.backgroundColor = [UIColor redColor];
    }
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBack)];
    [_animationView addGestureRecognizer:tapGesture];
    return _animationView;
    
}
@end
