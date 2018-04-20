//
//  GroupAnimationVC.m
//  FirstProject
//
//  Created by MacBook Air on 17/11/17.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import "GroupAnimationVC.h"

@interface GroupAnimationVC ()

@property(nonatomic,strong)UIView *animationView;

@end

@implementation GroupAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 重写父类的方法
- (void)initView {
    [super initView];
    [self animationView];
    
}
- (NSArray *)arr {
    return @[@"同时",@"连续"];
}
- (void)clickButton:(UIButton *)button {
    switch (button.tag) {
        case 0:
            [self meanwhileAnimation];
            break;
        case 1:
            [self continuousGroupAnimation];
            break;
        default:
            break;
    }
}
#pragma mark animation Methods
- (void)meanwhileAnimation {
    //移动
    CAKeyframeAnimation *kfAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *v0 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH / 2 -50, SCREEN_HEIGHT / 2 - 50)];
    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH / 2 -50, SCREEN_HEIGHT / 2)];
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)];
    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2 + 50)];
    NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH / 2 + 50, SCREEN_HEIGHT / 2 + 50)];
    kfAnimation.values = @[v0,v1,v2,v3,v4];
    
    //缩放
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAnimation.toValue = [NSNumber numberWithFloat:0.2];
    [basicAnimation setAutoreverses:YES];
    
    //动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[kfAnimation,basicAnimation];
    group.duration = 3;
    [self.animationView.layer addAnimation:group forKey:@"groupAnimation"];
}

- (void)continuousGroupAnimation {
    //获取时间
    CFTimeInterval currentTime = CACurrentMediaTime();
    NSString *str = [NSString stringWithFormat:@"%f",currentTime];
    NSLog(@"........%@",str);
    
    //移动
    CAKeyframeAnimation *kfAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *v0 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH / 2 -50, SCREEN_HEIGHT / 2 - 50)];
    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH / 2 -50, SCREEN_HEIGHT / 2)];
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)];
    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2 + 50)];
    NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH / 2 + 50, SCREEN_HEIGHT / 2 + 50)];
    kfAnimation.values = @[v0,v1,v2,v3,v4];
    kfAnimation.duration = 2;
    kfAnimation.beginTime = currentTime;
    [self.animationView.layer addAnimation:kfAnimation forKey:@"123"];
    
    //旋转
    CAKeyframeAnimation *kfAnimation1 = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    NSValue *v5 = [NSNumber numberWithFloat:M_PI / 4];
    NSValue *v6 = [NSNumber numberWithFloat:- M_PI / 4];
    kfAnimation1.values = @[v5,v6];
    kfAnimation1.repeatCount =  MAXFLOAT;
    kfAnimation1.duration = 0.4;
    [kfAnimation1 setAutoreverses:YES];
    
    kfAnimation1.beginTime = currentTime + 2;
    [self.animationView.layer addAnimation:kfAnimation1 forKey:@"456"];
    
}
#pragma mark lazy
- (UIView *)animationView {
    if (_animationView == nil) {
        _animationView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 -50, SCREEN_HEIGHT / 2 - 50, 100, 100)];
        [self.view addSubview:_animationView];
        _animationView.backgroundColor = [UIColor redColor];
    }
    return _animationView;
}
@end
