//
//  NSObject+Tools.m
//  FirstProject
//
//  Created by Peyton on 2018/7/24.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "NSObject+Tools.h"

@implementation NSObject (Tools)

- (UIImage *)screenShotWithView:(UIView *)view Frame:(CGRect )imageRect {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT), NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenShotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShotImage;
}

@end
