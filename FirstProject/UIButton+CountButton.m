//
//  UIButton+CountButton.m
//  FirstProject
//
//  Created by MacBook Air on 2018/1/30.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "UIButton+CountButton.h"

@implementation UIButton (CountButton)

- (void)countDownTime:(NSInteger)time withNomalTitle:(NSString *)nomalTitle countDownTitle:(NSString *)cDTitle finishBlock:(void (^)())finishBlock isInteraction:(BOOL)isInteraction {
    
    __block NSInteger timeLine = time;
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (timeLine <= 0) {//计时结束
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:nomalTitle forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        }else {
            //计时中
            int seconds=timeLine % 61;
            //回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:[NSString stringWithFormat:@"%@%ds",cDTitle,seconds] forState:UIControlStateNormal];
                self.userInteractionEnabled = isInteraction;
            });
            timeLine --;
            
        }
    });
    dispatch_resume(timer);
}

//原来的方法
- (void)countDownWithTime:(NSInteger)timeLine withTitle:(NSString *)title andCountDownTitle:(NSString *)subTitle countDoneBlock:(void(^)())countDoneBlock isInteraction:(BOOL)isInteraction{
    __block NSInteger timeout = timeLine; // 倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); // 每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                //设置界面的按钮显示 根据自己需求设置
                self.userInteractionEnabled = YES;
                [self setTitle:title forState:UIControlStateNormal];
                self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
            });
            
        }else{
            
            //            int minutes = timeout / 60;
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];;
            if (seconds < 10) {
                strTime = [NSString stringWithFormat:@"%.1d", seconds];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                //                NSLog(@"____%@",strTime);
                
                [self setTitle:[NSString stringWithFormat:@"%@s%@",strTime,subTitle] forState:UIControlStateNormal];
                
                self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
                
                self.userInteractionEnabled = isInteraction;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}

@end
