//
//  AnimationCenterVC.h
//  FirstProject
//
//  Created by MacBook Air on 17/11/16.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationCenterVC : UIViewController

@property(nonatomic,strong)NSArray *arr;

- (void)initView;

- (void)clickButton:(UIButton *)button;

@end
