//
//  UILabel+GoodLooking.h
//  FirstProject
//
//  Created by MacBook Air on 2018/3/1.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (GoodLooking)
+ (void)changeLineSpacingForLabel:(UILabel *)label WithSpace:(float)space;
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;
@end
