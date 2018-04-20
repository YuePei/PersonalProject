//
//  CustomMBProgressHUD.h
//  FirstProject
//
//  Created by Peyton on 2018/3/20.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomMBProgressHUD : NSObject

//使用此方法,能够创建一个自定义视图,标题,详情描述,几秒后隐藏 的MBProgressHUD
+ (void)setHudWithImageName:(UIView *)view title:(NSString *)title description:(NSString *)description andHideAfterDelay:(float)delay;

@end
