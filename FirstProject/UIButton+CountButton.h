//
//  UIButton+CountButton.h
//  FirstProject
//
//  Created by MacBook Air on 2018/1/30.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CountButton)
/*
 time:          倒计时的时间
 nomalTitle:    正常显示的标题
 cDTitle:       倒计时时显示的标题
 finishBlock:   倒计时完成后要做的事情
 isInteraction: 倒计时时是否可交互
 */
- (void)countDownTime:(NSInteger)time withNomalTitle:(NSString *)nomalTitle countDownTitle:(NSString *)cDTitle finishBlock:(void (^)())finishBlock isInteraction:(BOOL)isInteraction;

- (void)countDownWithTime:(NSInteger)timeLine withTitle:(NSString *)title andCountDownTitle:(NSString *)subTitle countDoneBlock:(void(^)())countDoneBlock isInteraction:(BOOL)isInteraction;
@end
