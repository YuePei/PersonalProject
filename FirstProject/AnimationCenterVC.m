//
//  AnimationCenterVC.m
//  FirstProject
//
//  Created by MacBook Air on 17/11/16.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import "AnimationCenterVC.h"

@interface AnimationCenterVC ()

@end

@implementation AnimationCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
    
    
}


- (void)initView {
    if(self.arr.count > 0) {
        for (int i = 0; i < self.arr.count; i ++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:[self reactForNumber:i totalNum:self.arr.count]];
            [self.view addSubview:btn];
            btn.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:156 / 255.0 blue:251 / 255.0 alpha:1];
            btn.titleLabel.font = [UIFont systemFontOfSize:13 weight:3];
            [btn setTitle:self.arr[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
        }
    }
    //声明SWRevealViewController
    SWRevealViewController *revealVC = self.revealViewController;
    //让手势左右滑动即可调出SWRevealViewController
    [revealVC panGestureRecognizer];
    [revealVC tapGestureRecognizer];
    
}

- (void)clickButton:(UIButton *)button{
    
}

- (CGRect)reactForNumber:(NSInteger)i totalNum:(NSInteger)a{
    NSInteger maxNum = 4;
    //列间距
    CGFloat columnMargin = 20;
    //行间距
    CGFloat rowMargin = 20;
    //每个按钮高度
    CGFloat btnHeight = (100 - ((a/maxNum + 1) * rowMargin))/(a/maxNum + 1);
    //每个按钮宽度
    CGFloat btnWidth = (SCREEN_WIDTH - columnMargin * (maxNum + 1)) / maxNum;
    //每个按钮y点位置
    CGFloat positionX = (i%maxNum) * btnWidth + (i%maxNum + 1) * columnMargin;
    //每个按钮y点位置
    CGFloat positionY = 523 + ((btnHeight + rowMargin) * (i/maxNum));
    return CGRectMake(positionX, positionY, btnWidth, btnHeight);
    
}


@end
