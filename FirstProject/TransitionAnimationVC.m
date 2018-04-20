//
//  TransitionAnimationVC.m
//  FirstProject
//
//  Created by MacBook Air on 17/11/17.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import "TransitionAnimationVC.h"

@interface TransitionAnimationVC ()

@property(nonatomic,strong)UIView *animationView;

@property(nonatomic,strong)UILabel *characterLabel;

@property(nonatomic,assign)int index;

@end

@implementation TransitionAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark 重写父类的方法
- (NSArray *)arr {
    return @[@"fade",@"movein",@"push",@"reveal",@"ripple"];
}
- (void)initView {
    [super initView];
    [self animationView];
    [self characterLabel];
    [self changeColorAndCharacter];
    
}
- (void)clickButton:(UIButton *)button {
    switch (button.tag) {
        case 0:
            [self fadeAnimation];
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            [self rippleAnimation];
            break;
            
        default:
            break;
    }
}

#pragma mark AnimationMethods
- (void)fadeAnimation {
    [self changeColorAndCharacter];
    CATransition *transitionAnimation = [CATransition animation];
    transitionAnimation.type = kCATransitionFade;
    transitionAnimation.subtype = kCATransitionFromBottom;
    transitionAnimation.duration = 1;
    [self.animationView.layer addAnimation:transitionAnimation forKey:@"fade"];
}
- (void)rippleAnimation {
    [self changeColorAndCharacter];
    CATransition *rippleAnimation = [CATransition animation];
    rippleAnimation.type = @"rippleEffect";
    rippleAnimation.subtype = kCATransitionFromLeft;
    rippleAnimation.duration = 1;
    [self.animationView.layer addAnimation:rippleAnimation forKey:@"rippleAnimation"];
}


#pragma mark Tool Methods
- (void)changeColorAndCharacter {
    if(self.index > 3) {
        self.index = 0;
    }
    NSArray *colorArr = [NSArray arrayWithObjects:[UIColor blueColor],[UIColor brownColor],[UIColor purpleColor],[UIColor grayColor], nil];
    NSArray *wordsArr = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
    self.animationView.backgroundColor = [colorArr objectAtIndex:self.index];
    self.characterLabel.text = [wordsArr objectAtIndex:self.index];
    
    self.index ++;
}


#pragma mark lazy
- (UIView *)animationView {
    if (_animationView == nil) {
        _animationView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 -100, SCREEN_HEIGHT / 2 - 100, 200, 200)];
        [self.view addSubview:_animationView];
    }
    return _animationView;
}

- (UILabel *)characterLabel {
    if (!_characterLabel) {
        _characterLabel = [[UILabel alloc]init];
        [self.animationView addSubview:_characterLabel];
        [_characterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.animationView);
        }];
        _characterLabel.textAlignment = NSTextAlignmentCenter;
        _characterLabel.font = [UIFont systemFontOfSize:22];
    }
    return _characterLabel;
}
@end
